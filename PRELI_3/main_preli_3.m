%% PROJET TS224 :

%% Préliminaire 2

close all;
clear;
clc;

% Partie 1

% Chargement signal de parole 
data = load('fcno04fz.mat');
x = data.fcno04fz;


fs = 8000;

% Définition filtre
k0_list = [1 10 100 300];

for i = 1:length(k0_list) % Boucle de filtrage pour les différents k0
    k0 = k0_list(i);
    h  = [1 zeros(1, k0-1) 1];

    y  = filter(h, 1, x);
    
    % Affichage
    subplot(4,1,i);
    plot(y, 'LineWidth', 1.1);
    title(sprintf('Signal filtré, k0 = %d', k0));
    xlabel('n'); 
    ylabel('Amplitude');
    grid on;
end


% Analyse nature filtre

% Pôles//Zéros
figure;
for i = 1:length(k0_list)
    k0 = k0_list(i);
    h  = [1 zeros(1, k0-1) 1];

    subplot(2,2,i);
    zplane(h, 1);
    title(sprintf('Pôles//zéros, k0 = %d', k0));
    grid on;
end


% Module
figure;
for i = 1:length(k0_list)
    k0 = k0_list(i);
    h  = [1 zeros(1, k0-1) 1];

    [H, w] = freqz(h, 1, 1024);

    subplot(2,2,i);
    plot(w/pi, abs(H), 'LineWidth', 1.2);
    title(sprintf('|H(e^{j\\omega})|, k0 = %d', k0));
    xlabel('\omega / \pi');
    ylabel('|H(e^{j\omega})|');
    grid on;
end



% signal de parole original
figure;
subplot(2,1,1);
plot(x);
title('Signal original');
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
spectrogram(x, hamming(256), 128, 512, fs, 'yaxis');
title('Spectrogramme du signal original');
colorbar;


% Filtre pour k0 = 100
k0 = 100;
h = [1 zeros(1, k0-1) 1];
y100 = filter(h, 1, x);


% signal de parole filtré
figure;
subplot(2,1,1);
plot(y100);
title(sprintf('Signal filtré (k0 = %d)', k0));
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
spectrogram(y100, hamming(256), 128, 512, fs, 'yaxis');
title(sprintf('Spectrogramme du signal filtré (k0 = %d)', k0));
colorbar;


% Ecoute du signal non filtré
sound(x, fs);

% Ecoute du signal filtré pour k0 = 100
sound(y100, fs);




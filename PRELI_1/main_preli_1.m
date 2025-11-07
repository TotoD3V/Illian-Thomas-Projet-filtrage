%% PROJET TS224 :

%% Préliminaires

close all;
clear;
clc;


N = 500;

% Bruit 
moy = 0;
sigma = sqrt(9);
bruit = moy + sigma*randn(1, N);

% Corrélation
Rx_biased = xcorr(bruit, "biased");
Rx_unbiased = xcorr(bruit, "unbiased");
f = linspace(-N+1, N, 2*N-1);

figure;

% Affichage
subplot(2,1,1);
plot(f, Rx_biased);
title('Estimateur biaisé');
xlabel('n');
ylabel('Amplitude');
legend('Rx biased', 'Rx biased');
grid on;

subplot(2,1,2);
plot(f, Rx_unbiased);
title('Estimateur non-biaisé');
xlabel('n');
ylabel('Amplitude');
legend('Rx unbiased', 'Rx unbiased');
grid on;


% Spectre de puissance
Y = fftshift(fft(Rx_biased));
P = sigma^2 * (abs(Y).^2)/N;

% Densité spectrale de puissance
DSPy = sigma^2 * ones(size(f));

% Affichage
figure;
plot(f, P, 'b', 'LineWidth', 1.2); hold on;
plot(f, DSPy, 'r--', 'LineWidth', 1.5);
title('Spectre de puissance estimé vs DSP théorique');
xlabel('f/f_n');
ylabel('Amplitude');
legend('Spectre estimé', 'DSP théorique');
grid on;







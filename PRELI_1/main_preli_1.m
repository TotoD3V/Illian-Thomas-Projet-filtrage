%% PROJET TS224 :

%% Préliminaires

close all;
clear;
clc;

% Partie 1

N = 4096;

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


% Partie 2

% Variables périodogrammes
Nfft   = 512;
M = 512;
Seg = 512;
fs = 1;

window_1 = hamming(256);
recouvrement_1 = length(window_1)/2;

window_2 = rectwin(M);
recouvrement_2 = 0;

% Périodogramme Welch
[pWelch, f1] = pwelch(bruit, window_1, recouvrement_1, Nfft, fs);

% Périodogramme Barlett
[pBartlett, f2] = pwelch(bruit, window_2, recouvrement_2, Nfft, fs);

% Périodogramme Daniel
[periodo, f3] = periodogram(bruit, [], 4096, fs);
pDaniel = movmean(periodo, 9); % Lissage


% Affichage
% Welch
figure;
subplot(3,1,1);
plot(f1, 10*log10(pWelch), 'b', 'LineWidth', 1.3);
title('Périodogramme de Welch');
xlabel('Fréquence normalisée f/f_n');
ylabel('DSP (dB)');
grid on;

% Bartlett
subplot(3,1,2);
plot(f2, 10*log10(pBartlett), 'g', 'LineWidth', 1.3);
title('Périodogramme de Bartlett');
xlabel('Fréquence normalisée f/f_n');
ylabel('DSP (dB)');
grid on;

% Daniell
subplot(3,1,3);
plot(f3, 10*log10(pDaniel), 'r', 'LineWidth', 1.3);
title('Périodogramme de Daniell');
xlabel('Fréquence normalisée f/f_n');
ylabel('DSP (dB)');
grid on;


% Partie 3



K = 100;

% Platitude via spectre de puissance (autocorr -> FFT)
[moy_SF_auto, ecart_type_auto] = platitude_spectrale(N, sigma, K, 'autocorr', window_1, recouvrement_1, Nfft, fs);

% Platitude via périodogramme de Welch
[moy_SF_welch, ecart_type_welch] = platitude_spectrale(N, sigma, K, 'welch', window_1, recouvrement_1, Nfft, fs);

fprintf('\nPlatitude spectrale\n');
fprintf('Autocorr -> FFT : moyenne = %f | écart-type = %f\n', moy_SF_auto, ecart_type_auto);
fprintf('Welch           : moyenne = %f | écart-type = %f\n', moy_SF_welch, ecart_type_welch);


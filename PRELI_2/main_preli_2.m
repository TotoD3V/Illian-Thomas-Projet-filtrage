clear; close all; clc;

freq = 8e3;
x = load("fcno01fz.mat");
x = x.fcno01fz;
N = length(x);

figure;
subplot(4,1,1);
t_ = (0:N-1)/freq;
plot(t_, x);
title("Données non bruitées");

y_5 = bruiter(x, 5);

subplot(4,1,2);
plot(t_, y_5);
title("Bruitage 5dB");

y_10 = bruiter(x, 10);

subplot(4,1,3);
plot(t_, y_10);
title("Bruitage 10dB");

y_15 = bruiter(x, 15);

subplot(4,1,4);
plot(t_, y_15);
title("Bruitage 15dB");

soundsc(y_5, freq);

figure;
subplot(2,1,1);
plot(t_, x);
title("Données non bruitées");

subplot(2,1,2);
fenetre = hamming(256);
overlap = length(fenetre)/2;
[s,f,t] = spectrogram(x,fenetre,overlap,N, freq);
SdB = 20*log10(abs(s));
imagesc(t,f,SdB);
axis xy;
xlabel("Time (s)");
ylabel("Frequency (Hz)");
colorbar;
title("Spectrogramme du signal");

figure;
subplot(2,1,1);
plot(t_, y_5);
title("Bruitage 5dB");

subplot(2,1,2);
fenetre = hamming(256);
overlap = length(fenetre)/2;
[s,f,t] = spectrogram(y_5,fenetre,overlap,N, freq);
SdB = 20*log10(abs(s));
imagesc(t,f,SdB);
axis xy;
xlabel("Time (s)");
ylabel("Frequency (Hz)");
colorbar;
title("Spectrogramme du signal");

figure;
subplot(2,1,1);
plot(t_, y_10);
title("Bruitage 10dB");

subplot(2,1,2);
fenetre = hamming(256);
overlap = length(fenetre)/2;
[s,f,t] = spectrogram(y_10,fenetre,overlap,N, freq);
SdB = 20*log10(abs(s));
imagesc(t,f,SdB);
axis xy;
xlabel("Time (s)");
ylabel("Frequency (Hz)");
colorbar;
title("Spectrogramme du signal");

figure;
subplot(2,1,1);
plot(t_, y_15);
title("Bruitage 15dB");

subplot(2,1,2);
fenetre = hamming(256);
overlap = length(fenetre)/2;
[s,f,t] = spectrogram(y_15,fenetre,overlap,N, freq);
SdB = 20*log10(abs(s));
imagesc(t,f,SdB);
axis xy;
xlabel("Time (s)");
ylabel("Frequency (Hz)");
colorbar;
title("Spectrogramme du signal");
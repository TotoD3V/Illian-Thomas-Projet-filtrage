freq = 8;
N = 4096;
x = randn(1,N);

figure;
subplot(4,1,1);
plot(x);
title("Données non bruitées");

y_5 = bruiter(x, 5);

subplot(4,1,2);
plot(y_5);
title("Bruitage 5dB");

y_10 = bruiter(x, 10);

subplot(4,1,3);
plot(y_10);
title("Bruitage 10dB");

y_15 = bruiter(x, 15);

subplot(4,1,4);
plot(y_15);
title("Bruitage 15dB");

figure;
subplot(2,1,1);
plot(x);
title("Données non bruitées");

subplot(2,1,2);
spectrogram(x);
title("Spectrogramme du signal");

figure;
subplot(2,1,1);
plot(y_5);
title("Bruitage 5dB");

subplot(2,1,2);
spectrogram(y_5);
title("Spectrogramme du signal");

figure;
subplot(2,1,1);
plot(y_10);
title("Bruitage 10dB");

subplot(2,1,2);
spectrogram(y_10);
title("Spectrogramme du signal");

figure;
subplot(2,1,1);
plot(y_15);
title("Bruitage 15dB");

subplot(2,1,2);
spectrogram(y_15);
title("Spectrogramme du signal");
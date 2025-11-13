function [moy_SF, ecarttype_SF] = platitude_spectrale(N, sigma, K, methode, window_1, recouvrement_1, Nfft, fs)

    Plat_spect = zeros(1, K);

    for k = 1:K

        % 1) bruit
        x = sigma * randn(1, N);

        % 2) spectre estimé selon la méthode
        switch methode

            case 'autocorr'
                Rx = xcorr(x, 'biased');
                P = (abs(fftshift(fft(Rx))).^2) / N;

            case 'welch'
                P = pwelch(x, window_1, recouvrement_1, Nfft, fs);

            case 'DSP'
                P = sigma^2 * ones(size(2 * N));

            otherwise
                error('Méthode inconnue : utilisez ''autocorr'' ou ''welch''');
        end

        % platitude spectrale
        P_moy_arith = mean(P);
        P_moy_geo   = exp(mean(log(P + eps)));
        Plat_spect(k) = P_moy_geo / P_moy_arith;

    end

    % stats sur les K réalisations
    moy_SF       = mean(Plat_spect);
    ecarttype_SF = std(Plat_spect);

end

function y = bruiter(s, RSB_dB)
    Ps = mean(s.^2);
    sigma = sqrt(Ps / (10^(RSB_dB / 10)));
    bruit = sigma * randn(size(s));
    y = s + bruit;
end
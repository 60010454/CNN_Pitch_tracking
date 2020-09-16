function [time ,freq] = predict(bin)
    
    cent = -3300:50:2600; % C2 - B6 w/ 50 cents interval

    cents_mapping =440 * 2.^(cent/1200);
    
    freq = cents_mapping(bin);
    freq = movmedian(freq,8);   % smooth the curve
    
    freq = interp1(cents_mapping,cents_mapping,freq,'nearest','extrap'); % Map back to cent

    step_size = 10;
    time = (0:max(size(bin)-1)) * step_size/1000;

end
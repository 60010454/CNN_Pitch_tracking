function [xn,fs] = dataset_generator_clean(pitch)
% Sampling
fs = 16000;                  % Sampling rate [Hz]
Ts = 1/fs;                   % Sampling period [s]
fNy = fs / 2;                % Nyquist frequency [Hz]
duration = 1;                % Duration [s]
t = 0 : Ts : duration-Ts;    % Time vector
noSamples = length(t);       % Number of samples


% Original signal
a_orig = 0.7;
b_orig = 1;
amp_orig = (b_orig-a_orig).*rand(1,1) + a_orig;

x_f0 = amp_orig.*sin(2 .* pi .* pitch .* t);


% Harmonics

% harmonic random amp
a_harm = 0;
b_harm = 0.2;

% hamonic random freq (inharmonic)
a_freq = 0.9999;
b_freq = 1.0001;


%harmonic no. random
r = randi([2 6],1,1);
%Create harmonic signals
for i = 1:r
    amp_harm(i) = (b_harm-a_harm).*rand(1,1) + a_harm;
    harm_freq(i) = (b_freq-a_freq).*rand(1,1) + a_freq;
    x(i,:) = amp_harm(i).*sin(2 .* pi .* i*pitch*harm_freq(i) .* t);
end

% % New signal
x_harm=sum(x);
xn = x_f0 + x_harm;
xn=xn-mean(xn);
xn=0.99*xn/max(abs(xn));
% sound(xn,fs)

end




function [xn,fs] = dataset_generator(pitch)
% clear;clc;close all;
% switch p
%     case 'C4'	
%         pitch= 261.63;	
%     case 'C#4'  
%         pitch= 277.18;	
%     case 'D4'	
%         pitch= 293.66;	
%     case 'D#4'  
%         pitch= 311.13;	
%     case 'E4'	
%         pitch= 329.63;	
%     case 'F4'	
%         pitch= 349.23;	
%     case 'F#4'  
%         pitch= 369.99;	
%     case 'G4'	
%         pitch= 392.00;	
%     case 'G#4'  
%         pitch= 415.30;	
%     case 'A4'	
%         pitch= 440.00;	
%     case 'A#4'  
%         pitch= 466.16;	
%     case 'B4'	
%         pitch= 493.88;	
%     case 'C5'	
%         pitch= 523.25;
% end

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
a_freq = 0.999;
b_freq = 1.001;


%harmonic no. random
r = randi([2 8],1,1);
%Create harmonic signals
for i = 1:r
    amp_harm(i) = (b_harm-a_harm).*rand(1,1) + a_harm;
    harm_freq(i) = (b_freq-a_freq).*rand(1,1) + a_freq;
    x(i,:) = amp_harm(i).*sin(2 .* pi .* i*pitch*harm_freq(i) .* t);
end
% % NOISE
amp_noise = (0.1-0.01).*rand(1,1)+0.01;
w_noise = amp_noise*rand(1, duration*fs);


% % New signal
x_harm=sum(x);
xn = x_f0 + x_harm;

r = randi([0,1]);

xn=xn+(w_noise*r);
xn=xn-mean(xn);
xn=0.99*xn/max(abs(xn));
% sound(xn,fs)

end




clear;close all;clc
[x,fs]=audioread('class21_18.wav');
x=x';
% Sampling
fs = 16000;                  % Sampling rate [Hz]
Ts = 1/fs;                   % Sampling period [s]
fNy = fs / 2;                % Nyquist frequency [Hz]
duration = 1;                % Duration [s]
t = 0 : Ts : duration-Ts;    % Time vector
noSamples = length(t);       % Number of samples
% % Frequency analysis
f = 0 : fs/noSamples : fs - fs/noSamples; % Frequency vector
% FFT
x_fft = abs(fft(x));

% % % Plot
title('C5')
subplot(2,1,1);
plot(t(:,1:320), x(:,1:320));
subplot(2,1,2);
plot(f,x_fft);
xlim([0 fNy]);

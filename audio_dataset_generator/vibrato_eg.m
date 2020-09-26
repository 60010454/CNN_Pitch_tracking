
clear all;
close all;

infile = 'G4_1.wav';

% read in wav sample
[ x, Fs] = audioread(infile);


%set Parameters for vibrato
% Change these to experiment with vibrato
% 
% Modfreq = 7; %7 Khz [6 - 10]
% Width = 0.0008; % 0.8 Milliseconds [0.0005 - 0.001]
 Modfreq = randi([6,10]); %[6 - 10] kHz
        Width = (0.001-0.0005).*rand(1,1) + 0.0005;% [0.5 - 0.1] Milliseconds 
% Do vibrato

y= vibrato(x, Fs, Modfreq, Width);

% write output wav files
% wavwrite(yvib, Fs,  'out_vibrato.wav');

% plot the original and equalised waveforms

figure(1)
hold on
plot(x(1:500),'r');
plot(y(1:500),'b');
title('Vibrato First 500 Samples');



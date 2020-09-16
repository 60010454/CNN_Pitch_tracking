clear;clc
% A#4  10
% A4   9
% B4   11
% C#4  1
% C4   0
% C5   12
% D#4  3
% D4   2
% E4   4
% F#4  6
% F4   5
% G#4  8
% G4   7
% pitch10= 466.16;	
% pitch9= 440.00;
% pitch11= 493.88;	
% pitch1= 277.18;
% pitch0= 261.63;	
% pitch12= 523.25;
% pitch3= 311.13;
% pitch2= 293.66;
% pitch4= 329.63;
% pitch6= 369.99;
% pitch5=349.23;	
% pitch8=415.30;
% pitch7=392.00;
% p = ones(130,1);
% pitch_label = [p(1:10)*10;
%                p(11:20)*9;
%                p(21:30)*11;
%                p(31:40)*1;
%                p(41:50)*0;
%                p(51:60)*12;
%                p(61:70)*3;
%                p(71:80)*2;
%                p(81:90)*4;
%                p(91:100)*6;
%                p(101:110)*5;
%                p(111:120)*8;
%                p(121:end)*7];
load('pitch_class.mat')
pitch_label_test = repelem(class,4)

save('pitch_label_test.mat','pitch_label_test')

        
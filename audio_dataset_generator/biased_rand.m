function r = biased_rand()
% clear;close all;clc
% Variables:
  min = 0;
  max = 1;
  bias = 0;     % (N)
  influence = 1;  %(D) [0.0, 1.0]

% Formula:
  rnd = rand(1,1) *(max - min) + min;
  mix = rand(1,1) * influence;
  value = rnd * (1 - mix) + bias *mix;
  r = round(value);
%   x = [0:.001:1];
%   y = normpdf(x,mean(value),std(value));plot(y)
end
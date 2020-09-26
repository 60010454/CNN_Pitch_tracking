clear;clc;

f_ref = 440;

cent = -3300:20:2600; % C2 - B6 w/ 20 cents interval

class =f_ref * 2.^(cent/1200);
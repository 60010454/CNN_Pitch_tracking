clear all;clc;
% pitch classes
f_ref = 440;

cent = -3300:50:2600; % C2 - B6 w/ 50 cents interval

class =f_ref * 2.^(cent/1200);
% class=class'
% save('pitch_class.mat','class')
% 
for k = 1:length(class)
    for i = 4:5
        [x,fs]=dataset_generator_noise(class(1,k));
        filename = sprintf('/Users/Tantep/Desktop/CNN_Pitch_tracking-master/mixed dataset audio/test/class%d_%d.wav',k,i);
        audiowrite(filename, x, fs);
    end
end
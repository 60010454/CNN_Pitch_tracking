clear all;clc
Folder = '/Users/Tantep/Desktop/CNN_Pitch_tracking-master/mixed dataset audio/train/';
filePattern = fullfile(Folder, '*_20.wav');
% filePattern = fullfile(Folder, '*.wav');
audioFiles   = dir(filePattern);
l=length(audioFiles);
for k = 1:l
  baseFileName = audioFiles(k).name;
  fullFileName = fullfile(Folder, baseFileName);
  fprintf('Now reading %s\n', fullFileName);
  [x(:,k), fs] = audioread(fullFileName);
% %   % Add FX
r=randi([1,3]);
    if r == 1
    
        Modfreq = randi([6,8]); %[6 - 10] kHz
        Width = (0.001-0.0005).*rand(1,1) + 0.0005;% [0.5 - 0.1] Milliseconds 
%         Width = 0.0008;
        x(:,k)= vibrato(x(:,k), fs, Modfreq, Width);

    elseif r == 2
    
        Fc=randi([5,10]);
        x(:,k) = tremolo(x(:,k),fs,Fc);
    else
        x(:,k) = flanger(x(:,k),fs);
    end
    x(:,k)=x(:,k)-mean(x(:,k));
    x(:,k)=0.99*x(:,k)/max(abs(x(:,k)));
    audiowrite(fullFileName,x(:,k),fs)
end


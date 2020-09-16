clear all;clc

P = '/home/tantep/Desktop/Senior_project_code/Sound_dataset/clean_4_octaves_dataset'; % directory path
S = dir(fullfile(P,'*.wav')); % get list of files in directory
C = natsortfiles({S.name}); % sort file names into order
l=length(C);
for k = 1:l
%   fprintf('Now reading %s\n', C{:,k});
  [audioArray(k,:), fs] = audioread(fullfile(P,C{:,k}));
end

for i = 1:size(audioArray,1)

    frames(i,:,:) = stride(audioArray(i,:));
    
end
% %  frames = 1904 x 101 x 1024 ----> #files x n_frames x 1024
% % reshape(frames,[],1024);

% save('audioArray_clean_train.mat','audioArray')


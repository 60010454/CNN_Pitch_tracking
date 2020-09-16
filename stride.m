% clear;clc
% filepath ='/home/tantep/Desktop/Senior_project_code/Sound_dataset/clean_4_octaves_dataset';
% [x,fs]=audioread([filepath '/class21_1.wav']);
function frames = stride(x)
model_fs = 16000;
step_size = 10; %ms
x = [zeros(512,1)' x zeros(512,1)'];

hop_length = round(model_fs * step_size / 1000);
n_frames = 1 + round((length(x) - 1024) / hop_length);
idx = mod( 1 + (0:n_frames-1)*hop_length, length(x));

for i=2:1:1024
    idx(i,:) = idx(1,:)+(i-1);
end
frames=x(idx);
frames = frames';
frames = frames - mean(frames, 2);
frames = frames ./ std(frames,0,2);

% % frames's size = n_frames x 1024

end
function [bin,frames] = get_activation(x, fs ,covnet)
   
%     Parameters
%     ----------
%     audio : np.ndarray [shape=(N,) or (N, C)]
%         The audio samples. Multichannel audio will be downmixed.
%     sr : int
%         Sample rate of the audio samples. The audio will be resampled if
%         the sample rate is not 16 kHz, which is expected by the model.
%     model_capacity : 'tiny', 'small', 'medium', 'large', or 'full'
%         String specifying the model capacity; see the docstring of
%         :func:`~crepe.core.build_and_load_model`
%     center : boolean
%         - If `True` (default), the signal `audio` is padded so that frame
%           `D[:, t]` is centered at `audio[t * hop_length]`.
%         - If `False`, then `D[:, t]` begins at `audio[t * hop_length]`
%     step_size : int
%         The step size in milliseconds for running pitch estimation.
%     verbose : int
%         Set the keras verbosity mode: 1 (default) will print out a progress bar
%         during prediction, 0 will suppress all non-error printouts.
%     Returns
%     -------
%     activation : np.ndarray [shape=(T, 360)]
%         The raw activation matrix
%  
    step_size=10;
%     model = covnet;
    model_fs = 16000;
%   make mono
    x = x(:,1);
%   resample audio if necessary
    if fs ~= model_fs
        x = resample(x,16000,fs);
    end
% 
%  CENTERED = pad so that frames are centered around their timestamps 
%  (i.e. first frame is zero centered). eg x= 1 2 3 4 -> pad 3 ->
%                                                0 0 0 1 2 3 4 0 0 0
        x = [zeros(512,1); x ;zeros(512,1)];
  

%   make 1024-sample frames of the audio with hop length of 10 milliseconds

    hop_length = round(model_fs * step_size / 1000);
    n_frames = 1 + round((length(x) - 1024) / hop_length);
    idx = mod( 1 + (0:n_frames-1)*hop_length, length(x));
    for i=2:1:1024
        idx(i,:) = idx(1,:)+(i-1);
    end
    frames=x(idx);
    frames = frames';

%     # normalize each frame -- this is expected by the model
    frames = frames - mean(frames, 2);
    frames = frames ./ std(frames,0,2);

%     # run prediction and convert the frequency bin weights to Hz
for j=1:size(frames,1)
    for i=1:size(frames,2)
  input(i,:,:,j) = frames(j,i)';
    end
end

   bin=zeros(size(input,4),1);
   
for i =1:size(input,4)
    bin(i) = double(classify(covnet,input(:,:,:,i)));
end
% input=frames;
%   out = double(classify(model,input));
%  out = input;
end
% [x,fs]=audioread('/home/tantep/Desktop/Senior_project_code/Sound_dataset/clean sound set/class3_3.wav');
% double(classify(covnet,input_test_clean(:,:,:,29))')
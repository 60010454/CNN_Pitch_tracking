clc
tic
% for j =1:size(out,4)
    for i =1:size(out,4)
bin(i,:) = double(classify(covnet,out(:,:,:,i))) ;

    end
%     x=x(1:size(out,4))
% end
toc
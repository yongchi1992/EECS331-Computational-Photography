sigmaSpatial = 4;
sigmaRange =  0.1;
img = imread('./Photos/2.jpg'); % ???unit8?(0~255)??
img = imresize(img, [1024, 768]);
I1  = im2double(img);    % ??????double?????0~1?
I1  = rgb2gray(I1);
output = bilateralFilter( I1, sigmaSpatial, sigmaRange);
imshow(output);
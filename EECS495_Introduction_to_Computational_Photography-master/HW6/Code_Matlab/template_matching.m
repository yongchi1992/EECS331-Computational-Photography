clc;
clear;
% load in the video
vd = 'VID.mp4';
v = VideoReader(vd);
i=1;
video = read(v);
[row column color numIm] = size(video);
sampled_video=video(:,:,:,1:round(numIm/60):end);
[row column color numIm] = size(sampled_video);
for k = 1: numIm
    gray_video(:,:,k) = rgb2gray(sampled_video(:,:,:,k));
end

% the template for registration
figure;
[template, rect_template] = imcrop(gray_video(:,:,1));


% variance

for i=1:row
    for j=1:column
        var_gray_video(i,j)=sum(double(gray_video(i,j,:)));
    end
end
normalized_var_gray_video = uint8(round(var_gray_video/max(max(var_gray_video))*255));



% search range for each frame to conduct template matching 

[search, rect_search] = imcrop(normalized_var_gray_video);



% crop an area of each frame at the same location with the same size

clear search;


for k = 1: numIm
    search(:,:,k) = imcrop(gray_video(:,:,k),rect_search);
end 



%conduct template matching of each frame

XWindowPixelShift = [];
YWindowPixelShift = [];
for k = 1: numIm
    [xoffSet,yoffSet] = correlation( template(:,:),search(:,:,k) );
    XWindowPixelShift(k) = xoffSet;
    YWindowPixelShift(k) = yoffSet;
end 

XPixShift=XWindowPixelShift-XWindowPixelShift(1);
YPixShift=YWindowPixelShift-YWindowPixelShift(1);





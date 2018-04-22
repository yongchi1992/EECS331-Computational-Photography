% refocus

figure;
[template, rect_template] = imcrop(gray_video(:,:,1));

[search, rect_search] = imcrop(normalized_var_gray_video);

clear search;

for k = 1: numIm
    search(:,:,k) = imcrop(gray_video(:,:,k),rect_search);
end 

XWindowPixelShift = [];
YWindowPixelShift = [];
for k = 1: numIm
    [xoffSet,yoffSet] = correlation( template(:,:),search(:,:,k) );
    XWindowPixelShift(k) = xoffSet;
    YWindowPixelShift(k) = yoffSet;
end 

XPixShift=XWindowPixelShift-XWindowPixelShift(1);
YPixShift=YWindowPixelShift-YWindowPixelShift(1);
for k = 1: numIm
    T(:,:,:,k) = imtranslate(sampled_video(:,:,:,k),[-XPixShift(k), -YPixShift(k)],'FillValues',255);
end

P = uint8(round(sum(T,4)/numIm));
Crop_P = imcrop(P,[max(abs(YPixShift)) max(abs(XPixShift)) column row]);
figure;
imshow(Crop_P);

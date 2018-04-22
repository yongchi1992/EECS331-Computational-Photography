%plot the pixel shift for each frame

figure;
scatter(XPixShift,YPixShift,'*');
title('Pixel shift for each frame of video');
ylabel('Y Pixel Shift');
xlabel('X Pixel Shift');
axis('square');




%synthetic aperture photograph
for k = 1: numIm
    T(:,:,:,k) = imtranslate(sampled_video(:,:,:,k),[-XPixShift(k), -YPixShift(k)],'FillValues',255);
end

P = uint8(round(sum(T,4)/numIm));
Crop_P = imcrop(P,[max(abs(YPixShift)) max(abs(XPixShift)) column row]);
figure;
imshow(Crop_P);

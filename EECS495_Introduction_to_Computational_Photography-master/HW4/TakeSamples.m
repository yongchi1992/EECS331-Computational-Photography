exposeTime = 17203200;
j=1;
while j <= 5
    image = imread(['./Photos/', num2str(exposeTime), '.jpg']);
    info = imfinfo(['./Photos/', num2str(exposeTime), '.jpg']);
    Im(:,:,j) = double(reshape(image, [ ], 3));
    exposureTime(j) = info.DigitalCamera.ExposureTime;
    exposeTime = exposeTime * 2;
    j = j + 1;
end
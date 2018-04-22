lnE = zeros(numPixels,3);
for i=1:numPixels
    g(:,1) = gR(Im(i,1,:)+1);
    lnE(i,1) = sum(g-log(exposureTime)')/5;
    
    g(:,1) = gG(Im(i,2,:)+1);
    lnE(i,2) = sum(g-log(exposureTime)')/5;
    
    g(:,1) = gB(Im(i,3,:)+1);
    lnE(i,3) = sum(g-log(exposureTime)')/5;
end

re_lnE = zeros(1944,2592,3);
for i=1:3
    re_lnE(:,:,i) = reshape(lnE(:,i), [], 2592);
end
[X,Y] = meshgrid(1:2592,1:1944);

figure;
h=pcolor(X,Y,flip(re_lnE(:,:,1)));
set(h,'edgecolor','none','facecolor','interp');
colorbar;
title('Recovered radiance map: Red (ln scale)');
figure;
h=pcolor(X,Y,flip(re_lnE(:,:,2)));
set(h,'edgecolor','none','facecolor','interp');
colorbar;
title('Recovered radiance map: Green (ln scale)');
figure;
h=pcolor(X,Y,flip(re_lnE(:,:,3)));
set(h,'edgecolor','none','facecolor','interp');
colorbar;
title('Recovered radiance map: Blue (ln scale)');


E = exp(lnE);

re_E = zeros(1944,2592,3);
for i=1:3
    re_E(:,:,i) = reshape(E(:,i), [], 2592);
end
figure;
imshow(uint8(re_E));
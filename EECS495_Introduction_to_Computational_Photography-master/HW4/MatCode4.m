clc
clear
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

numPixels = length(Im);
pointsTake = 1000;
ids = randperm(numPixels,pointsTake);
for i=1:5
    ZR(:,i)= Im(ids,1,i);
    ZG(:,i) = Im(ids,2,i);
    ZB(:,i) = Im(ids,3,i);
end

l = 5; % [.1, 5]

[gR,lER]=gsolve(ZR,log(exposureTime),l);
[gG,lEG]=gsolve(ZG,log(exposureTime),l);
[gB,lEB]=gsolve(ZB,log(exposureTime),l);


for i=1:5
    XR(:,i)= lER + log(exposureTime(i));
    XG(:,i) = lEG + log(exposureTime(i));
    XB(:,i) = lEB + log(exposureTime(i));
end

figure;
for i=1:5
    scatter(XR(:,i),ZR(:,i),'.','b');
    hold on;
end
plot(gR,0:255,'r','linewidth',2);
title('Response curve for red channel');
xlabel('log exposure');
ylabel('pixel value(Z)')
legend('fitted data','response curve')
hold off;

figure;
for i=1:5
    scatter(XG(:,i),ZG(:,i),'.','b');
    hold on;
end
plot(gG,0:255,'r','linewidth',2);
title('Response curve for green channel');
xlabel('log exposure');
ylabel('pixel value(Z)')
legend('fitted data','response curve')
hold off;

figure;
for i=1:5
    scatter(XB(:,i),ZB(:,i),'.','b');
    hold on;
end
plot(gB,0:255,'r','linewidth',2);
title('Response curve for blue channel');
xlabel('log exposure');
ylabel('pixel value(Z)')
legend('fitted data','response curve')
hold off;

figure;
plot(gR,0:255,'r','linewidth',2);
hold on;
plot(gG,0:255,'g','linewidth',2);
hold on;
plot(gB,0:255,'b','linewidth',2);
title('Response curves');
xlabel('log exposure');
ylabel('pixel value(Z)')
legend('Red','Green','Blue')
hold off;

%%%%%Recover the HDR radiance map of the scene

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


%%%%%Implement a tone mapping algorithm to display HDR image 

for c=1:3
    E_norm(:,c) = (E(:,c) - min(E(:,c)))./(max(E(:,c)) - min(E(:,c)));
end

re_E_norm = zeros(1944,2592,3);
for i=1:3
    re_E_norm(:,:,i) = reshape(256*E_norm(:,i)-1, [], 2592);
end

figure;
subplot(1,2,1);
imshow(uint8(re_E_norm));
subplot(1,2,2);
hist(E_norm);
legend('r','g','b');

gamma = 0.2;
E_ga = E_norm.^gamma;

for c=1:3
    E_gamma(:,c) = (E_ga(:,c) - min(E_ga(:,c)))./(max(E_ga(:,c)) - min(E_ga(:,c)));
end

re_E_gamma = zeros(1944,2592,3);
for i=1:3
    re_E_gamma(:,:,i) = reshape(256*E_gamma(:,i)-1, [], 2592);
end

figure;
subplot(1,2,1);
imshow(uint8(re_E_gamma));
subplot(1,2,2);
hist(E_gamma);
legend('r','g','b');

L = rgb2gray(E_gamma);

L_avg = exp(mean(mean(log(L))));

a= 0.7;

T = a/L_avg *L;


L_tone = T.*(1+T./((max(max(T)))^2))./(1+T);

M = L_tone./L;

RGB_new = (265*E_gamma-1).*M;

re_RGB_new = zeros(1944,2592,3);
for i=1:3
    re_RGB_new(:,:,i) = reshape(RGB_new(:,i), [], 2592);
end

re_RGB_new = uint8(re_RGB_new);

figure;
imshow(re_RGB_new);
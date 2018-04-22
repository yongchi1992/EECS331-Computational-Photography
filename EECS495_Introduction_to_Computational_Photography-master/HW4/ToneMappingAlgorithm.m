for c=1:3
    E_norm(:,c) = (E(:,c) - min(E(:,c)))./(max(E(:,c)) - min(E(:,c)));
end

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

a= 1.0;

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
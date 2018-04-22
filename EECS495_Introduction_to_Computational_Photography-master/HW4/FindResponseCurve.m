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

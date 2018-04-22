t = Tiff('upper/0.dng','r');
im = read(t);
im = imresize(im2uint8(im),0.3);
[row col] = size(im);
im3=zeros(row,col); %sum=0
im4=zeros(row,col);
x=zeros();
x2=zeros();
x3=zeros();
x4=zeros();
x5=zeros();

for a=0:49
    %t = Tiff('1.dng','r');
    t = Tiff(['upper/',num2str(a),'.dng'],'r');
    im = read(t);
    im2 = imresize(im2uint8(im),0.3);
    %figure; imshow(im2);
    
    %mean
    for i = 1:row
        for j = 1:col
            im3(i,j)=im3(i,j)+im2(i,j);
        end
    end
    
    %variance
    for i = 1:row
        for j = 1:col
          im4(i,j)=im4(i,j)+((im2(i,j)-(im3(i,j))/a)^2);
        end
    end
    
    %hist
    x(a+1)=im2(50,50);
    x2(a+1)=im2(100,200);
    x3(a+1)=im2(500,700);
    x4(a+1)=im2(10,60);
    x5(a+1)=im2(200,300);
end

im3(i,j)=im3(i,j)/50;
im4(i,j)=im4(i,j)/50;

%figure; imshow(uint8(im3));
%figure; imshow(uint8(im4));
%figure; hist(x); 
%figure; hist(x2); 
%figure; hist(x3); 
%figure; hist(x4); 
%figure; hist(x5);


%figure; imshow(im4);

%x=im3;
%y=im4;

%figure; plot(x,y);
%p = polyfit(x,y,1);

for i=1:row
    for j=1:col
        SNR(i,j)= im3(i,j)/sqrt(im4(i,j));
    end
end

x=im3;
y=SNR;
figure;plot(x,y);


[row col] = size(im3);
k = 1;
tmp = zeros(255);
cntx = zeros(255);

for i = 1:row
    for j = 1:col
        tmp(im3(i, j)) = tmp(im3(i, j)) + im4(i,j);
        cntx(im3(i, j)) = cntx(im3(i, j)) + 1;
    end
end

for i = 1:255
    if cntx(i) > 0
        plotx(k) = i;
        ploty(k) = tmp(i) / cntx(i);
        k = k + 1;
    end
end

figure; plot(plotx, ploty);

p=polyfit(plotx,ploty,1);

figure; plot(p);




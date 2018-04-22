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
plot(plotx, ploty);

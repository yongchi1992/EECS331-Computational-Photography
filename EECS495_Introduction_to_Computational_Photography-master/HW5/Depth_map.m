% Compute a depth map from the focal stack

% convert your focal stack to grayscale images

for k = 1: numIm
    I_gray(:,:,k) = rgb2gray(I_2(:,:,:,k));
end

% focus measure

L = [1,4,1;4,-20,4;1,4,1]/6;

for k=1:numIm
    L_im = imfilter(I_gray(:,:,k),L,'replicate');
    M(:,:,k) = L_im.*L_im;
end

% The depth can then be calculated for each pixel by 
%finding the index into the focal stack where the focus is maximum

for i=1:row
    for j = 1:column
       D_map(i,j)=max(M(i,j,:));
    end
end

figure;
imshow(D_map);

%which image in the stack a given pixel is in focus

for i=1:row
    for j = 1:column
       index = find(M(i,j,:)==max(M(i,j,:)));
       if length(index)>1
           D(i,j) = index(1);
       else
           D(i,j) = index;
       end
    end
end

% A depth index map

D_index_map = uint8(D.*(255/max(max(D))));
figure;
imshow(D_index_map);

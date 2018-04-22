% Recover an all-focus image of the scene 

for c = 1:color
    for i=1:row
        for j = 1:column
            A(i,j,c) = I_2(i,j,c,D(i,j));
        end
    end
end

figure;
imshow(A)



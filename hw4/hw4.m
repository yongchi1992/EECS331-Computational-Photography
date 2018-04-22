 %You will need to choose a value for the regularization parameter l. 
 %Try a few different values in the range [0.1,5]    
l = 2;


for t=1:7
    im = imread(['hw4/',num2str(t),'.jpg']);
    im_r = im(:,:,1);
    im_g = im(:,:,2);
    im_b = im(:,:,3);
    
    for i=1:10
        Z_r(i,t) = im_r(i,i);
        Z_g(i,t) = im_g(i,i);
        Z_b(i,t) = im_b(i,i);
    end
end

max = 200000000;
ex = 1000000;
j = 1;
while ex + ex < max
    ex = ex + ex;
    B(j) = ex;
    j = j + 1;
end


%gsolve(Z_r,B,l);
%gsolve(Z_g,B,l);
gsolve(Z_b,B,l);


%for i=1:10
 %   for j=1:8
  %      sum(i,j) = lE(i) + B(j);
   % end
%end

%x=Z;
%y=sum;
%plot(x,y);

 
 
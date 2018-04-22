i={'1.0' '1.5' '2.25' '3.375' '5.0625' '7.59375'};
t = 1;
while(t <= 6)
    im = imread(['./Photos/',char(i(t)),'.jpg']);
    I(:,:,:,t) = im;
    t = t + 1;
end

% compensate for this small change in magnification.

f = 2.95/1000;
v=[1.0 1.5 2.25 3.375 5.0625 7.59375];
u = 1./(1/f-1./v);

m = u(end)./u;
mr = m;
mi = 2-m;

[row column color numIm] = size(I);

for k=1:numIm
    for i=1:row
        for j = 1:column
            
            if i<=row/2
                mx = round(i*mi(k));
                if(mx<=0)
                    mx=1;
                end
            else
                mx = round(i*mr(k));
                if(mx>row)
                    mx=row;
                end
            end
            
            if j<=column/2
                my = round(j*mi(k));
                if(my<=0)
                    my=1;
                end
            else
                my = round(j*mr(k));
                if(my>column)
                    my=column;
                end
            end
  
           I_2(i,j,:,k) = I(mx,my,:,k); 
        end
    end
end

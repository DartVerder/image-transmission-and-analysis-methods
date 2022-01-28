im = imread('03_barb.TIF');
figure; imshow(im); impixelinfo; title('�������� �����������');
i = double(im);
[n , m] = size(i);
contour=zeros(n,m);
grad = zeros (n,m);
s1=zeros(n,m);
s2=zeros(n,m);
for j = 2:n
    for k = 2:m
        s1(j,k) = i(j,k) - i(j-1,k);
        s2(j,k) = i(j,k) - i(j,k-1);
       
        s1(j,k)=abs(s1(j,k));
        s2(j,k)=abs(s2(j,k));
        grad(j,k) = max(s1(j,k), s2(j,k));
        if(grad(j,k))>=13
            contour(j,k)=255;
        else 
            contour(j,k)=0;
        end
            
    end
end

sim1 = uint8(s1);
figure; imshow(sim1);impixelinfo; title('������� �������� �� �');
sim2 = uint8(s2);
figure; imshow(sim2);impixelinfo; title('������� �������� �� �');
gradim = uint8(grad);
figure; imshow(gradim);impixelinfo; title('������ ���������');
h = imhist(gradim, 256);
contourim=uint8(contour);
figure; imshow(contour);impixelinfo; title('�������� ����������� max');
figure; plot(0:255,h); title('����������� ������ ���������');

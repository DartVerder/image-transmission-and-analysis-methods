im = imread('03_barb.TIF');
figure; imshow(im); impixelinfo; title('�������� �����������');
i = double(im);
[n , m] = size(i);
contour=zeros(n,m);
grad = zeros (n,m);
s1=zeros(n,m);
s2=zeros(n,m);
for j = 2:n-1
    for k = 2:m-1
        s1(j,k) = (1/6)*(-i(j-1,k-1)-i(j-1,k)-i(j-1,k+1)+i(j+1,k-1)+i(j+1,k)+i(j+1,k+1));
        s2(j,k) = (1/6)*(-i(j-1,k-1)+i(j-1,k+1)-i(j,k-1)+i(j,k+1)-i(j+1,k-1)+i(j+1,k+1));
        grad(j,k) = sqrt(s1(j,k)^2+s2(j,k)^2);
        s1(j,k)=abs(s1(j,k));
        s2(j,k)=abs(s2(j,k));
        if(grad(j,k))>=10
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
figure; plot(0:255,h); title('����������� ������ ���������');
contourim=uint8(contour);
figure; imshow(contour);impixelinfo; title('������� "����� ��������� �����"');


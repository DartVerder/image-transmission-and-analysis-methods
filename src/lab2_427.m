im = imread('03_barb.TIF');
figure; imshow(im); impixelinfo; title('Исходное изображение');
i = double(im);
[n , m] = size(i);
contour=zeros(n,m);
lap = zeros (n,m);
s=zeros(n,m);
for j = 2:n-1
    for k = 2:m-1
        s(j,k) = (2*i(j-1,k-1)-i(j-1,k)+2*i(j-1,k+1)-i(j,k-1)-4*i(j,k)-i(j,k+1)+2*i(j+1,k-1)-i(j+1,k)+2*i(j+1,k+1));
        lap(j,k) = abs(s(j,k));
        if(lap(j,k))>=55
            contour(j,k)=255;
        else 
            contour(j,k)=0;
        end
            
    end
end

lapim = uint8(lap);
figure; imshow(lapim);impixelinfo; title('Оценка лаплассиана');
h = imhist(lapim, 256);
figure; plot(0:255,h); title('Гистограмма оценки лаплассиана');
contourim=uint8(contour);
figure; imshow(contour);impixelinfo; title('Контуры "Метод согласования для Лаплассиана');
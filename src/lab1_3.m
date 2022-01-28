%��������� ���������
im = imread('LENA.TIF');
im = imresize(im, 2);
figure; imshow(im); impixelinfo; title('�������� �����������');
figure; imhist(im, 256); impixelinfo; title('����������� ��������� �����������');
i = double(im);
limit=120;
[n , m] = size(i);
out = zeros (n,m);
for j = 1:n
    for k = 1:m
        if i(j,k) >= limit
            out(j,k) = 255;
        end
    end
end
outim = uint8(out);
x = 0:255;
y = 0.*(x<limit) + 255.*(x>=limit);
figure; plot(x,y), grid on, title ('������ ������� ������������� ��������������');
figure; imshow(outim);impixelinfo; title('��������� �����������');
h = imhist(outim, 256);
figure; plot(0:255,h); title('����������� ���������� �����������');

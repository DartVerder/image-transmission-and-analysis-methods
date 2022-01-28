%���������������� �����������
im = imread('LENA.TIF');
im = imresize(im, 2);
figure; imshow(im); impixelinfo; title('�������� �����������');
figure; imhist(im,256); title('����������� ��������� �����������');
h = imhist(im, 256);
i = double(im);
x1 = (max(max(i)));
x2 = (min(min(i)));
a = 255 / (x1 - x2) ;
b = (-255 * x2) / (x1 - x2);
[N, M] = size(i);
v = ones(N, M) .* b;
out = a .* i + v ;
figure;plot (i,out);title ('������ ������� ������������� ��������������');
outim = uint8(out);
figure; imshow(outim);impixelinfo; title('����������������� �����������');
figure; imhist(outim,256); title('����������� ������������������ �����������');
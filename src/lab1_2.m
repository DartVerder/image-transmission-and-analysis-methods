%����������� �����������
im = imread('LENA.TIF');
im = imresize(im, 2);
figure; imshow(im); impixelinfo; title('�������� �����������');
figure; imhist(im,256); title('����������� ��������� �����������');
i = double(im);
h = imhist(im,256);
k = h / numel(im);%������� ������������� �����������
f = cumsum(k); %������������ ������� �������������
out = 255*f(i+1);
x=0:255;
figure; plot(0:255,f); title('������������ �������');
ymax=max(max(i));
ymin=min(min(i));
y=(ymax-ymin)*f+ymin;
figure; plot(0:255,y); title('������ ������� ������������� ��������������');

outim = uint8(out);
figure; imshow(outim);impixelinfo; title('����������� ����� �����������');
figure; imhist(outim,256); title('����������� ����������� ����� �����������');

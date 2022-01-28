%Эквализация гистограммы
im = imread('LENA.TIF');
im = imresize(im, 2);
figure; imshow(im); impixelinfo; title('Исходное изображение');
figure; imhist(im,256); title('Гистограмма исходного изображения');
i = double(im);
h = imhist(im,256);
k = h / numel(im);%функция распределения вероятности
f = cumsum(k); %интегральная функция распределения
out = 255*f(i+1);
x=0:255;
figure; plot(0:255,f); title('Интегральная функция');
ymax=max(max(i));
ymin=min(min(i));
y=(ymax-ymin)*f+ymin;
figure; plot(0:255,y); title('График функции поэлементного преобразования');

outim = uint8(out);
figure; imshow(outim);impixelinfo; title('Изображение после эквализации');
figure; imhist(outim,256); title('Гистограмма изображения после эквализации');

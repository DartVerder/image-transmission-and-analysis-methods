%figure; imshow(); impixelinfo; title()
close all; 
I = imread ('04_boat.tif');
figure; imshow(I); impixelinfo; title('Исходное изображение');

N = length(I(:,1));
K = 10;

I = double(I);
I1 = fft2(I);
I1 = fftshift(I1);

O = zeros(N);
for i = 1:N
    for j = 1:N
        if (i - N/2)^2 + (j - N/2)^2 < N^2 / (K * pi)
            O(i, j) = 1;
        end
    end
end
I1 = I1 .* O;

I1 = ifftshift(I1);
I1 = ifft2(I1);
Ir = real(I1);
Ii = imag(I1);
I1 = abs(I1);
Io = uint8(I1);
figure; imshow(Io); impixelinfo; title('Восстановленное изображение')
figure; imshow(O); impixelinfo; title('Маска');
sum = 0;
for i = 1:N
    for j = 1:N
        sum = sum + (I(i, j) - I1(i, j))^2;
    end
end
sum = sum / N^2;
disp(['Квадратичная погрешность = ', num2str(sum)]);
varR = (var(Ir(:)));%mean(var(Ir));
disp(['Дисперсия вещественной части = ', num2str(varR)]);
varI = (var(Ii(:)));
disp(['Дисперсия мнимой части = ', num2str(varI)]);




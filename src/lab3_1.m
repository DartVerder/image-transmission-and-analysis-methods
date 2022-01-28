clear; 
clc;
close all;
I=255*(checkerboard(64,1)>0.5);%чб шахматная доска 128 * 128 со стороной 4 ячейки
I=double(I);
I(I<128)=96;
I(I>=128)=160;
d_i = var(I(:)); 
I = uint8(I);

%Gaussian //зашумленное изображение
m=0;
d1=d_i/(256*256);
d10=d_i/(256*256*10);
G1 = imnoise(I,'gaussian',m,d1);
G10 = imnoise(I,'gaussian',m,d10);
%Gaussian //шум
G = uint8(zeros(128));
G_1 = imnoise(G, 'gaussian', 0.5, d1);
D_G1 = var(double(G_1(:)));
G_10 = imnoise(G, 'gaussian', 0.5, d10);
D_G10 = var(double(G_10(:)));
%Импульсный шум //зашумленное изображение
J1 = imnoise(I,'salt & pepper',0.1);
d_J1 = var(double(J1(:)));%дисперсия искажения
J2 = imnoise(I,'salt & pepper',0.3);
d_J2 = var(double(J1(:)));%дисперсия искажения
%Импульсный шум //шум
N = uint8(zeros(128));
J_1 = imnoise(128+N, 'salt & pepper', 0.01);
D1 = var(double(J_1(:)));
J_2 = imnoise(128+N, 'salt & pepper', 0.03);
D2 = var(double(J_2(:)));
%медианный фильтр
MGaus1=medfilt(G1);
MGaus10=medfilt(G10);
MImp1=medfilt(J1);
MImp2=medfilt(J2);
%линейный сглаживающий фильтр
h_l = (1/9)*[1 1 1; 1 1 1; 1 1 1];
f_G1 = filter2(h_l, double(G1)); 
f_G10 = filter2(h_l, double(G10));
f_J1 = filter2(h_l, double(J1)); 
f_J2 = filter2(h_l, double(J2));
%дисперсия искажения
is_G1=mean((double(G1(:)) - double(I(:))).^2); 
is_G10=mean((double(G10(:)) - double(I(:))).^2); 
is_Imp1=mean((double(J1(:)) - double(I(:))).^2); 
is_Imp2=mean((double(J2(:)) - double(I(:))).^2); 
%СКО^2 = дисперсия ошибки фильтрации
sko_MG1=sum((double(MGaus1(:)) - double(I(:))).^2)/(128*128); 
sko_MG10=sum((double(MGaus10(:)) - double(I(:))).^2)/(128*128); 
sko_MImp1=sum((double(MImp1(:)) - double(I(:))).^2)/(128*128); 
sko_MImp2=sum((double(MImp2(:)) - double(I(:))).^2)/(128*128); 
sko_linG1 = sum((double(f_G1(:)) - double(I(:))).^2)/(128*128);
sko_linG10 = sum((double(f_G10(:)) - double(I(:))).^2)/(128*128);
sko_linJ1 = sum((double(f_J1(:)) - double(I(:))).^2)/(128*128);
sko_linJ2 = sum((double(f_J2(:)) - double(I(:))).^2)/(128*128);
%коэффициент снижния шума
kMG1=sko_MG1/is_G1;
klinG1=sko_linG1/is_G1;
kMG10=sko_MG10/is_G10;
klinG10=sko_linG10/is_G10;
kMImp1=sko_MImp1/is_Imp1;
klinImp1=sko_linJ1/is_Imp1;
kMImp2=sko_MImp2/is_Imp2;
klinImp2=sko_linJ2/is_Imp2;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=uint8(I);
figure; imshow(I);impixelinfo; title ('Исходное изображение');

figure; imshow(G_1);impixelinfo; title ('Белый шум 1');
figure; imshow(G_10);impixelinfo; title ('Белый шум 0.1');
figure; imshow(J_1);impixelinfo; title ('Импульсный шум 0.1');
figure; imshow(J_2);impixelinfo; title ('Импульсный шум 0.3');

figure; imshow(G1);impixelinfo; title ('Зашумленное изображение. Белый шум 1');
figure; imshow(G10);impixelinfo; title ('Зашумленное изображение. Белый шум 0.1');
figure; imshow(J1);impixelinfo; title ('Зашумленное изображение. Импульсный шум 0.1');
figure; imshow(J2);impixelinfo; title ('Зашумленное изображение. Импульсный шум 0.3');

figure; imshow(MGaus1);impixelinfo; title ('Медианная фильтрация. Белый шум 1');
figure; imshow(MGaus10);impixelinfo; title ('Медианная фильтрация. Белый шум 0.1');
figure; imshow(MImp1);impixelinfo; title ('Медианная фильтрация. Импульсный шум 0.1');
figure; imshow(MImp2);impixelinfo; title ('Медианная фильтрация. Импульсный шум 0.3');
figure; imshow(uint8(f_G1));impixelinfo; title ('Сглаживающий фильтр. Белый шум 1');
figure; imshow(uint8(f_G10));impixelinfo; title ('Сглаживающий фильтр. Белый шум 0.1');
figure; imshow(uint8(f_J1));impixelinfo; title ('Сглаживающий фильтр. Импульсный шум 0.1');
figure; imshow(uint8(f_J2));impixelinfo; title ('Сглаживающий фильтр. Импульсный шум 0.3');

%реализация взвешенного медианного фильтра
function MedFilt=medfilt(k)
MedFilt=k;
[n , m] = size(k);
h=[0,1,0;1,3,1;0,1,0]; %вид фильтра
for j = 2:n-1 
    for k = 2:m-1
        tmp = [MedFilt(j-1,k),MedFilt(j,k-1),MedFilt(j,k),MedFilt(j,k),MedFilt(j,k),MedFilt(j,k+1),MedFilt(j+1,k)];
        tmp1=sort(tmp);
        MedFilt(j,k)=tmp1(round(sum(sum(h))/2));
    end
end
end

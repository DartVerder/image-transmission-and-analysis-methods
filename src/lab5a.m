%figure; imshow(); impixelinfo; title()
%figure; subplot(1, 2, 1); imshow(X); subplot(1, 2, 2); imshow(X);

X = imread('04_boat.tif');
r = 1;
figure; imshow(X);
Q = MyDifCodeFast(X, 5, r);
Y = MyDifDeCodeFast(Q, 5, r);
disp(['e = ',num2str(max(max(double(X) - Y))),',  (e <= 5)']);
Y = uint8(Y);
figure; imshow(Y);

Q = MyDifCodeFast(X, 10, r);
Y = MyDifDeCodeFast(Q, 10, r);
disp(['e = ',num2str(max(max(double(X) - Y))),',  (e <= 10)']);
Y = uint8(Y);
figure; imshow(Y);

Q = MyDifCodeFastWithF(X, 0, r);
Q = uint8(Q);
figure; imshow(Q);

Q = MyDifCodeFast(X, 5, r);
Q = uint8(Q);
figure; imshow(Q);
Q = MyDifCodeFast(X, 10, r);
Q = uint8(Q);
figure; imshow(Q);
%figure; imshow(); impixelinfo; title()

X = imread('04_boat.tif');
e = 5;
r = 1;
figure; imshow(X);
Q = MyDifCode(X, e, r);
Y = MyDifDeCode(Q, e, r);
%Q = MyDifCodeFast(X, e, r);
%Y = MyDifDeCodeFast(Q, e, r);
Y = uint8(Y);
figure; imshow(Y);
Q = MyDifCode(X, e, 2);
Y = MyDifDeCode(Q, e, 2);
Y = uint8(Y);
figure; imshow(Y);
Q = MyDifCode(X, e, 3);
Y = MyDifDeCode(Q, e, 3);
Y = uint8(Y);
figure; imshow(Y);
Q = MyDifCode(X, e, 4);
Y = MyDifDeCode(Q, e, 4);
Y = uint8(Y);
figure; imshow(Y);
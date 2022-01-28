%figure; imshow(); impixelinfo; title()

X = imread('04_boat.tif');
E1 = zeros(1, 50);
E2 = zeros(1, 50);
for e = 1:50
    E1(e) = entropy(MyDifCodeFast(X, e, 1));
    E2(e) = entropy(MyDifCodeFast(X, e, 2));
end
figure; plot(1:50, E1); hold on; plot(1:50, E2, '--'); hold off;
function Y = MyDifDeCode(Q, e, r)
N = length(Q(1,:));
switch r
    case 2
        a1 = 0.5; a2 = 0.5; a3 = 0; a4 = 0;
    case 3
        a1 = 0.25; a2 = 0.25; a3 = 0.25; a4 = 0.25;
    case 4
        a1 = 1; a2 = 1; a3 = -1; a4 = 0;
    otherwise
        a1 = 1; a2 = 0; a3 = 0; a4 = 0;
end
P = zeros(N);
Y = zeros(N);
Y = padarray(Y,[1 1],128,'pre');
Y = padarray(Y,[0 1],128,'post');
for i = 1:N
    for j = 1:N
        P(i, j) = a1 * Y(i + 1, j) + a2 * Y(i, j + 1) + a3 * Y(i, j) + a4 * Y(i, j + 2);
        Y(i + 1, j + 1) = P(i, j) + Q(i, j) * (2 * e + 1);
    end
end
Y = Y(2:N+1, 2:N+1);
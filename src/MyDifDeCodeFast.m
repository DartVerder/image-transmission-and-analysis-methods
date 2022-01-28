function Y = MyDifDeCodeFast(Q, e, r)
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
for j = 1:N
    P(:, j) = a1 * Y(2:N+1, j) + a2 * Y(1:N, j + 1) + a3 * Y(1:N, j) + a4 * Y(1:N, j + 2);
    Y(2:N+1, j + 1) = P(:, j) + Q(:, j) * (2 * e + 1);
end
Y = Y(2:N+1, 2:N+1);
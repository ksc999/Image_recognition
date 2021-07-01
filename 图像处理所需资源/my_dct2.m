function C = my_dct2(P)
    P = double(P - 128);    % minus the DC component, and convert uint8 to double
    tmp = size(P);
    N = tmp(1);             % get size of the input block
    D = zeros(N);           
    % compute matrix D
    D(1, :) = sqrt(1/2);
    for a = 2: N
        for b = 1: N
            D(a, b) = cos((a-1)* (2*b-1)* pi/ (2*N));
        end
    end
    D = D * sqrt(2/ N);
    disp(D);

    % compute C
    C = D* P* D';
end
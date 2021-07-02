function I_before_encrypt = quantify_before_encrypt(I, Q)
    % get height and width of the input image
    s = size(I);
    H = s(1);
    W = s(2);
    N = 8;

    % tackle by blocks
    I_before_encrypt = zeros(H, W);
    for a = 1 : N : (H/N - 1) * N + 1
        for b = 1 : N : (W/N - 1) * N + 1
            block_tmp = I(a : a+N-1 , b : b+N-1);
            block_tmp_C = dct2(double(block_tmp) - 128);
            block_tmp_Q = round(block_tmp_C ./ Q);
            I_before_encrypt(a : a+N-1 , b : b+N-1) = block_tmp_Q;
        end
    end
end
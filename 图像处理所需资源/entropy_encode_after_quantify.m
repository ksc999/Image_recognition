function Z_q = entropy_encode_after_quantify(I_before_encrypt)
    % get height and width of the input image
    s = size(I_before_encrypt);
    H = s(1);
    W = s(2);
    N = 8;

    % tackle by blocks
    Z_q = zeros(N*N , H*W / (N*N));
    for a = 1 : N : (H/N - 1) * N + 1
        for b = 1 : N : (W/N - 1) * N + 1
            block_tmp_Q = I_before_encrypt(a : a+N-1 , b : b+N-1);
            block_tmp_Z = zig_zag_code(block_tmp_Q);
            tmp = floor(a/N) * (W/N) + floor(b/N) + 1;
            Z_q(: , tmp) = block_tmp_Z;
        end
    end
end
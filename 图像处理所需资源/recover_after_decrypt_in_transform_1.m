function I_recover = recover_after_decrypt_in_transform_1(H, W, I, Q)
    N = 8;
    I_recover = zeros(H, W);
    for a = 1 : N : (H/N - 1) * N + 1
        for b = 1 : N : (W/N - 1) * N + 1
            tmp_block = I(a : a+N-1 , b : b+N-1);
            tmp_block = tmp_block .* Q;
            tmp_block = idct2(tmp_block);
            tmp_block = round(tmp_block + 128);
            I_recover(a : a+N-1 , b : b+N-1) = tmp_block;
        end
    end
    I_recover = uint8(I_recover);
end
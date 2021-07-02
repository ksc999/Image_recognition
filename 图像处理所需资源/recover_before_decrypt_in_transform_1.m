function I = recover_before_decrypt_in_transform_1(H, W, DC_decode_array, AC_decode_array)
    I = zeros(H, W);
    step_range = W / 8;
    storage_index = [
        1,2,6,7,15,16,28,29,...
        3,5,8,14,17,27,30,43,...
        4,9,13,18,26,31,42,44,...
        10,12,19,25,32,41,45,54,...
        11,20,24,33,40,46,53,55,...
        21,23,34,39,47,52,56,61,...
        22,35,38,48,51,57,60,62,...
        36,37,49,50,58,59,63,64
    ];
    for k = 1: length(DC_decode_array)
        tmp_DC = DC_decode_array(k);
        tmp_AC = AC_decode_array(63 * (k-1) + 1: 63 * k);
        tmp_block = [tmp_DC, tmp_AC];
        tmp_block = tmp_block(storage_index);
        tmp_block = reshape(tmp_block, 8, 8);
        tmp_block = tmp_block';
        w_index = mod(k - 1, step_range);
        h_index = floor((k - 1) / step_range);
        I(h_index * 8 + 1: (h_index + 1) * 8, w_index * 8 + 1: (w_index + 1) * 8) = tmp_block;
    end
end
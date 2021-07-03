function I_encrypt_in_transform_2 = encrypt_in_transform_2(I, huff)
    I_encrypt_in_transform_2 = I;
    [H, W] = size(I);
    step = H * W / 64;
    % set mod(huff, step) = 0, in order to do matrix transform
    huff = [huff, zeros(1, step - mod(length(huff), step))]; 
    iter_time = length(huff) / step;   
    huff = reshape(huff, step, iter_time);
    huff = huff';
    for k = 1 : iter_time
        [x, y] = find_zig_zag_position(k);
        for a = 0 : H/8 - 1
            for b = 0 : W/8 - 1
                tmp = I_encrypt_in_transform_2(a * 8 + 1 + x, b * 8 + 1 + y);
                code = huff(k, a * W/8 + b + 1);
                I_encrypt_in_transform_2(a * 8 + 1 + x, b * 8 + 1 + y) = code + 2 * floor(tmp / 2);
            end
        end
    end
end



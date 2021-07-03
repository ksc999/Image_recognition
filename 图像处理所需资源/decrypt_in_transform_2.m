function huff = decrypt_in_transform_2(I)
    [H, W] = size(I);
    huff = zeros(1, H*W);
    step = H * W / 64;
    for k = 1 : 64
        [x, y] = find_zig_zag_position(k);
        for a = 0 : H/8 - 1
            for b = 0 : W/8 - 1
                tmp = I(a * 8 + 1 + x, b * 8 + 1 + y);
                position = (k-1) * step + a * (W/8) + b + 1;
                huff(position) = mod(tmp, 2);
            end
        end
    end
end


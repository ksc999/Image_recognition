function huff = decrypt_in_space(I)
    [H, W] = size(I);
    huff = zeros(1, H*W);
    index = 1;
    while index < length(huff)
        k = floor((index-1) / 64);
        W_range = W / 8;
        a = floor(k / W_range);
        b = mod(k, W_range);
        block = I(a * 8 + 1: (a+1) * 8, b * 8 + 1: (b+1) * 8);
        huff(index: index + 63) = block_decrypt_in_space(block);
        index = index + 64;
    end
end

function huff_decrypt = block_decrypt_in_space(block)
    huff_decrypt = zeros(1, 64);
    for a = 1: 8
        for b = 1: 8
            point = block(a, b);
            huff_decrypt(8 * (a-1) + b) = mod(point, 2);
        end
    end
end
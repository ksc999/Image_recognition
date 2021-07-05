function huff = decrypt_in_transform_3(I)
    [H, W] = size(I);
    huff = zeros(1, H * W / 64);
    for a = 0 : H/8 - 1
        for b = 0 : W/8 - 1
            block = I(a * 8 + 1: (a+1) * 8, b * 8 + 1: (b+1) * 8);
            code = block_decrypt_in_transform_3(block);
            if abs(code) == 1
                huff(a * W / 8 + b + 1) = max(0, code);
            else
                break;
            end
        end
    end
end

function code = block_decrypt_in_transform_3(block)
    block_zig_zag = zig_zag_code(block);
    index = find(block_zig_zag ~= 0);
    max_index = index(end);
    if abs(block_zig_zag(max_index)) ~= 1
        code = 0;
    else
        code = block_zig_zag(max_index);
    end
end

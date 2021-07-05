function I_encrypt_in_transform_3 = encrypt_in_transform_3(I, huff)
    I_encrypt_in_transform_3 = I;
    [~, W] = size(I);
    index = 1;
    while index <= length(huff)
        k = index - 1;
        W_range = W / 8;
        a = floor(k / W_range);
        b = mod(k, W_range);
        code = huff(index);
        block = I(a * 8 + 1: (a+1) * 8, b * 8 + 1: (b+1) * 8);
        I_encrypt_in_transform_3(a * 8 + 1: (a+1) * 8, b * 8 + 1: (b+1) * 8) = block_encrypt_in_transform_3(block, code);
        index = index + 1;
    end
end

function block_encrypt = block_encrypt_in_transform_3(block, code)
    block_zig_zag = zig_zag_code(block);
    index = find(block_zig_zag ~= 0);
    max_index = index(end);
    if max_index <= 63
        encode_index = max_index + 1;
    else
        encode_index = 64;
    end
    if code == 1
        block_zig_zag(encode_index) = 1;
    else
        block_zig_zag(encode_index) = -1;
    end
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
    block_encrypt = block_zig_zag(storage_index);
    block_encrypt = reshape(block_encrypt, 8, 8);
    block_encrypt = block_encrypt';
end
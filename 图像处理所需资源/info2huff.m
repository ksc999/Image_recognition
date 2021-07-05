function huff = info2huff(info, DC)
    huff = [];
    info_de = abs(info);
    for k = 1: length(info_de)
        tmp = info(k);
        tmp_binary = flip(de2bi(abs(tmp)));
        tmp_index = DC(length(tmp_binary) + 1, :);
        tmp_Huffman_length = tmp_index(1);
        tmp_Huffman = tmp_index(2: 1+tmp_Huffman_length);
        huff = [huff, tmp_Huffman, tmp_binary];
    end
    END_OF_HUFF = [1,1,1,1,1,1,1,1,1,1,0];
    huff = [huff, END_OF_HUFF];
end
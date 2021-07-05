function info = huff2info(huff, DC)
    info = [];
    index = 1;
    [H, ~] = size(DC);
    while index < length(huff)

        flag = 1;
        % scan DC to fit Hufffman code
        for k = 1: H
            tmp_Huffman_length = DC(k, 1);
            tmp_Huffman = DC(k, 2: tmp_Huffman_length+1);
            if isequal(tmp_Huffman, huff(index: index+tmp_Huffman_length-1))
                index = index + tmp_Huffman_length;
                flag = 0;
                break
            end
        end

        % if no matched Huffman code, just terminate the decode
        if flag
            break;
        end

        % get data
        if k == 1   % data = 0 should be considered exclusively
            tmp_data_de = 0;
            index = index + 1;
        else
            tmp_data_bi = huff(index: index+k-2);
            tmp_data_de = bi2de(flip(tmp_data_bi));
            index = index + k - 1;
        end
        
        % put data into info
        info = [info, mod(tmp_data_de, 128)];
        info = char(info);
    end
end
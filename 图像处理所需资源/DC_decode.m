function DC_decode_array = DC_decode(DC_stream, DC)
    DC_decode_array = [];
    index = 1;
    [H, ~] = size(DC);
    while(index < length(DC_stream))

        % scan DC to fit Hufffman code
        for k = 1: H
            tmp_Huffman_length = DC(k, 1);
            tmp_Huffman = DC(k, 2: tmp_Huffman_length+1);
            if isequal(tmp_Huffman, DC_stream(index: index+tmp_Huffman_length-1))
                index = index + tmp_Huffman_length;
                break
            end
        end
        
        % get data
        if k == 1   % data = 0 should be considered exclusively
            tmp_data_de = 0;
            index = index + 1;
        else
            tmp_data_bi = DC_stream(index: index+k-2);
            if tmp_data_bi(1) == 0  % if data < 0, more operation is needed
                is_negative = 1;
            else
                is_negative = 0;
            end
            if is_negative
                tmp_data_bi = 1 - tmp_data_bi;
                tmp_data_de = -bi2de(flip(tmp_data_bi));
            else
                tmp_data_de = bi2de(flip(tmp_data_bi));
            end
            index = index + k - 1;
        end
        
        % put data into DC_decode_array
        if isempty(DC_decode_array) 
            DC_decode_array = [DC_decode_array, tmp_data_de];
        else
            tmp_data_de = DC_decode_array(end) - tmp_data_de;
            DC_decode_array = [DC_decode_array, tmp_data_de];
        end
    end
end
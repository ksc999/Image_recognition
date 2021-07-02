function AC_decode_array = AC_decode(AC_stream, AC)
    AC_decode_array = [];
    index = 1;
    tmp_array = []; % store one block's AC code
    [H, ~] = size(AC);
    while index < length(AC_stream) 
        
        
        % Huffman decode
        flag = 1;   % deal with EOB condition
        for k = 1: H
            tmp_Huffman_length = AC(k, 3);
            tmp_Huffman = AC(k, 4: tmp_Huffman_length+3);
            tmp_index_end = index+tmp_Huffman_length-1;
            if tmp_index_end >= length(AC_stream)   % end of AC_stream: out of range!
                break;
            end
            if isequal(tmp_Huffman, AC_stream(index: tmp_index_end))
                index = index + tmp_Huffman_length;
                flag = 0;
                break
            end
        end

        % get run, size and data itself
        if flag % EOB condition or 16-zeros condition
            if index + 10 <= length(AC_stream) && isequal(AC_stream(index: index + 10), [1,1,1,1,1,1,1,1,0,0,1])
                % 16-zeros
                zeros_filled = zeros(1, 16);
                tmp_array = [tmp_array, zeros_filled];
                index = index + 11;
                continue;
            else
                % EOB
                zeros_filled = zeros(1, 63 - length(tmp_array));
                tmp_array = [tmp_array, zeros_filled];
                AC_decode_array = [AC_decode_array, tmp_array];
                tmp_array = [];
                index = index + 4;
                continue;
            end
        end
        tmp_run = AC(k, 1); % run
        tmp_size = AC(k, 2);    % size
        tmp_data_bi = AC_stream(index: index + tmp_size - 1);
        if tmp_data_bi(1) == 0
            tmp_data_bi = 1 - tmp_data_bi;
            tmp_data_de = -bi2de(flip(tmp_data_bi));
        else
            tmp_data_de = bi2de(flip(tmp_data_bi));
        end
        index = index + tmp_size;

        % update tmp_array
        tmp_array = [tmp_array, zeros(1, tmp_run), tmp_data_de];
    end
end
function I = decode(filename, Q, DC, AC)
    % load necessary data
    data = load(filename);
    H = data.I_H;
    W = data.I_W;
    DC_stream = data.DC_stream;
    AC_stream = data.AC_stream;
    DC_decode_array = DC_decode(DC_stream, DC);
    AC_decode_array = AC_decode(AC_stream, AC);
    I = recover(H, W, DC_decode_array, AC_decode_array, Q);
end

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

function I = recover(H, W, DC_decode_array, AC_decode_array, Q)
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
        tmp_block = tmp_block .* Q;
        tmp_block = idct2(tmp_block);
        tmp_block = round(tmp_block + 128);
        w_index = mod(k - 1, step_range);
        h_index = floor((k - 1) / step_range);
        I(h_index * 8 + 1: (h_index + 1) * 8, w_index * 8 + 1: (w_index + 1) * 8) = tmp_block;
        
    end
    I = uint8(I);
end
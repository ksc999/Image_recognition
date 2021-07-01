function [DC_stream, AC_stream] = encode(Z_q, DC, AC)
    [H, ~] = size(Z_q);
    Z_q_DC = Z_q(1, :);
    Z_q_AC = Z_q(2:H, :);
    DC_stream = DC_encode(Z_q_DC, DC);
    AC_stream = AC_encode(Z_q_AC, AC);
end

function DC_stream = DC_encode(Z_q_DC, DC)
    % create empty DC stream
    DC_stream = [];

    % do difference first
    DC_diff = -diff(Z_q_DC);
    DC_diff = [Z_q_DC(1), DC_diff];

    % do DC encode
    for k = 1 : length(DC_diff)
        tmp = DC_diff(k);
        % 0 situation must be considerd exclusively, 
        % for de2bi(0) also has length 1
        if tmp == 0 
             % tmp_Huffman = [0, 0];
             % tmp_binary = 0;
             DC_stream = [DC_stream, [0,0,0]];
             continue;
        end
        tmp_if_negative = (tmp < 0);
        tmp_binary = flip(de2bi(abs(tmp)));  % de2bi's input can only be non-negatve
        if tmp_if_negative
            tmp_binary = 1 - tmp_binary;    % 1-component of negative input
        end
        tmp_index = DC(length(tmp_binary) + 1, :);
        tmp_Huffman_length = tmp_index(1);
        tmp_Huffman = tmp_index(2: 1+tmp_Huffman_length);
        DC_stream = [DC_stream, tmp_Huffman, tmp_binary];
    end
end

function AC_stream = AC_encode(Z_q_AC, AC)
    % create empty AC stream
    AC_stream = [];
    [~, W] = size(Z_q_AC);

    % outer loop gets every block's AC information
    for a = 1 : W
        block_AC = Z_q_AC(:, a);   
        block_non_zeros = [0; find(block_AC ~= 0)]; % find non-zeros of one block

        % inner loop computes AC_stream
        for b = 2 : length(block_non_zeros)

            % get run and number
            tmp = block_AC(block_non_zeros(b));
            count_zeros = block_non_zeros(b) - block_non_zeros(b-1) - 1;

            % tackle the situation when run >= 16
            while count_zeros >= 16
                AC_stream = [AC_stream, [1,1,1,1,1,1,1,1,0,0,1]];
                count_zeros = count_zeros - 16;
            end

            % get size
            tmp_if_negative = (tmp < 0);
            tmp_binary = flip(de2bi(abs(tmp)));  % de2bi's input can only be non-negatve
            if tmp_if_negative
                tmp_binary = 1 - tmp_binary;    % 1-component of negative input
            end
            tmp_length = length(tmp_binary);

            % get Huffman code
            tmp_index = AC(10 * count_zeros + tmp_length, :);
            tmp_Huffman_length = tmp_index(3);
            tmp_Huffman = tmp_index(4: 3 + tmp_Huffman_length);
            AC_stream = [AC_stream, tmp_Huffman, tmp_binary];
        end

        % add EOB to AC_stream
        AC_stream = [AC_stream, [1,0,1,0]];
    end
end
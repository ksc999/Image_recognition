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


function I_recoverd = jpeg_transmission(I, Q, DC, AC)
    Z_q = quantify(I, Q);
    [DC_stream, AC_stream] = encode(Z_q, DC, AC);
    [I_H, I_W] = size(I);
    save('jpegcodes.mat', 'I_H', 'I_W', 'DC_stream', 'AC_stream');
    I_recoverd = decode('jpegcodes.mat', Q, DC, AC);
end

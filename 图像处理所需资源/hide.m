% preparation
info = load('JpegCoeff.mat');
Q = info.QTAB;
DC = info.DCTAB;
AC = info.ACTAB;
string = ['Tom is a spy! Amy is also a spy! They are going to kill you on Monday! ',...
        'I think the best way to prevent this disaster is to eat some ice cream.'...
        'However, my mom do not think so. She said you should do your homework first.'...
        'Tom is a spy! Amy is also a spy! They are going to kill you on Monday! ',...
        'I think the best way to prevent this disaster is to eat some ice cream.',...
        'However, my mom do not think so. She said you should do your homework first.,'...
        'Tom is a spy! Amy is also a spy! They are going to kill you on Monday! ',...
        'I think the best way to prevent this disaster is to eat some ice cream.',...
        'However, my mom do not think so. She said you should do your homework first.'];
disp('before encrypt:');
disp(string);
huff = info2huff(string, DC);
I = load('hall.mat');
I = I.hall_gray;

% No.1
I_encrypt = encrypt_in_space(I, huff);
I_recoverd = jpeg_transmission(I_encrypt, Q, DC, AC);
imshow(I_recoverd);
huff_decrypt = decrypt_in_space(I_recoverd);
info_decrypt = huff2info(huff_decrypt, DC);
disp('after_decrypt:');
disp(info_decrypt);
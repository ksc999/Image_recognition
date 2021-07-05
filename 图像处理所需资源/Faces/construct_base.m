function base_vecter = construct_base(L)
    base = zeros(33, 2 ^ (3 * L));
    for k = 1 : 33
        I = imread(string(k) + '.bmp');
        base(k, :) = convert_image(L, I);
    end
    base_vecter = sum(base) / 33;
end
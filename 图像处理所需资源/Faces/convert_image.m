function vector = convert_image(L, I)
    vector = zeros(1, 2 ^ (L * 3));
    [H, W, ~] = size(I);
    for a = 1 : H 
        for b = 1 : W
            num = convert_point(L, I(a, b, :));
            vector(num + 1) = vector(num + 1) + 1;
        end
    end
    vector = vector / sum(vector);
end

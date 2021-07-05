function num = convert_point(L, input)
    tmp = zeros(1, L * 3);
    for k = 1 : 3
        pure_tmp = flip(de2bi(input(k)));
        pure_tmp = [zeros(1, 8 - length(pure_tmp)), pure_tmp];
        tmp((k-1) * L + 1 : k * L) = pure_tmp(1 : L);
    end
    num = bi2de(flip(tmp));
end
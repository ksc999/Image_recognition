function distance = compute_distance(L, base_vector, I)
    v = convert_image(L, I);
    distance = 1 - sum(sqrt(v) .* sqrt(base_vector));
end
STEP = 100;
L = 3;
I_tot = imread('test.bmp');
I_rotate = imadjust(I_tot, [.2 .3 0; .6 .7 1],[]);
imshow(I_rotate);
T = load('result.mat');
base_vector_3 = T.base_vector_3;
% imshow('test.bmp');
% h = images.roi.Polygon(gca,'Position',[20,20;100,100;200,200]);
[H, W, ~] = size(I_rotate);
H_range = floor(H / STEP);
W_range = floor(W / STEP);
% distance_matrix = zeros(H_range, W_range);
% for a = 0 : H_range - 1
%     for b = 0 : W_range - 1
%         image_tmp = I_rotate(a * STEP + 1 : (a+1) * STEP, b * STEP + 1 : (b+1) * STEP, :);
%         distance = compute_distance(L, base_vector_3, image_tmp);
%         distance_matrix(a + 1, b + 1) = distance;
%     end
% end
% T = load('result.mat');
% distance_matrix_4 = T.distance_matrix_4;
imshow(I_rotate);
position_matrix = zeros(2, 4);
for a = 0 : H_range - 1
    for b = 0 : W_range - 1
        if distance_matrix(a + 1, b + 1) < 0.7
            up = a * STEP + 1;
            down = (a+1) * STEP;
            left = b * STEP + 1;
            right = (b+1) * STEP;
            position_matrix = [left, up; right, up; right, down; left, down];
            images.roi.Polygon(gca,'Position',position_matrix, 'FaceAlpha', 0, 'InteractionsAllowed', 'none');
        end
    end
end


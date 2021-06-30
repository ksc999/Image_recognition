clear, clc;

% No.1
I = load('hall.mat');
I = I.hall_color;
% imshow(I);
% h = images.roi.Circle(gca,'Center',[84,60],'Radius',60, 'Color', 'r', 'FaceAlpha', 0, 'InteractionsAllowed', 'none');

% No.2
for a = 1: 3
    for b = 1: 120
        for c = 1: 168
            if mod(b+c, 2) == 0
                I(b, c, a) = 0;
            end
        end
    end
end
imshow(I);
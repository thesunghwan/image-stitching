function [ ] = show_images(li, ci, ri)
    subplot(1,3,1), imshow(li);
    subplot(1,3,2), imshow(ci);
    subplot(1,3,3), imshow(ri);
end
run('~/MATLAB/vlfeat/toolbox/vl_setup');

left_image = imread('keble/keble_a.jpg');
center_image = imread('keble/keble_b.jpg');
right_image = imread('keble/keble_c.jpg');

li_gray = rgb2gray(left_image);
ci_gray = rgb2gray(center_image);
ri_gray = rgb2gray(right_image);

[fl, dl] = vl_sift(single(li_gray));
[fc, dc] = vl_sift(single(ci_gray));
[fr, dr] = vl_sift(single(ri_gray));

[matches_cl, scores_cl] = vl_ubcmatch(dc, dl);
[matches_cr, scores_cr] = vl_ubcmatch(dc, dr);

H_cl = ransac(matches_cl, fc, fl, 300, 200, 3);
H_cr = ransac(matches_cr, fc, fr, 300, 200, 3);

bbox = [-400 1200 -200 700];
reference_space = vgg_warp_H(single(center_image), eye(3), 'linear', bbox);
left_space= vgg_warp_H(single(left_image), H_cl, 'linear', bbox);
right_space = vgg_warp_H(single(right_image), H_cr, 'linear', bbox);

stitched_image = double(max(max(reference_space, left_space), right_space))/255;

imshow(stitched_image);

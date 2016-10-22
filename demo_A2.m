%load the vl_feat library for sift
run('~/MATLAB/vlfeat/toolbox/vl_setup');

%load images
left_image = imread('keble/keble_a.jpg');
center_image = imread('keble/keble_b.jpg');
right_image = imread('keble/keble_c.jpg');

%turn rgb images to grayscale for analysis
li_gray = rgb2gray(left_image);
ci_gray = rgb2gray(center_image);
ri_gray = rgb2gray(right_image);

%Begin finding features and descriptors
%The first returned variable is features the second returned variable is
%descriptors.
%The first argument is dectector name to use. One of 'Harrison Corner', 'SIFT'
%The second argument is descriptor name to use. One of 'template', 'SIFT'
[fl, dl] = find_features_and_descriptor('SIFT', 'SIFT', li_gray);
[fc, dc] = find_features_and_descriptor('SIFT', 'SIFT', ci_gray);
[fr, dr] = find_features_and_descriptor('SIFT', 'SIFT', ri_gray);
%End finding features and descriptors

%Begin matching descriptors
[matches_cl, scores_cl] = vl_ubcmatch(dc, dl);
[matches_cr, scores_cr] = vl_ubcmatch(dc, dr);
%End matching descriptors

%Begin RANSAC and find Homography
H_cl = ransac(matches_cl, fc, fl, 300, 200, 3);
H_cr = ransac(matches_cr, fc, fr, 300, 200, 3);
%end RANSAC

%Warp Images
bbox = [-400 1200 -200 700];
reference_space = vgg_warp_H(single(center_image), eye(3), 'linear', bbox);
left_space= vgg_warp_H(single(left_image), H_cl, 'linear', bbox);
right_space = vgg_warp_H(single(right_image), H_cr, 'linear', bbox);

stitched_image = double(max(max(reference_space, left_space), right_space))/255;
%Warp Images

imshow(stitched_image);

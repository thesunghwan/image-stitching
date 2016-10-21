run('~/MATLAB/vlfeat/toolbox/vl_setup');

left_image = imread('keble_a.jpg');
center_image = imread('keble_b.jpg');
right_image = imread('keble_c.jpg');

li_gray = rgb2gray(left_image);
ci_gray = rgb2gray(center_image);
ri_gray = rgb2gray(right_image);

[fl, dl] = vl_sift(single(li_gray));
[fc, dc] = vl_sift(single(ci_gray));
[fr, dr] = vl_sift(single(ri_gray));


[matches_cl, scores_cl] = vl_ubcmatch(dc, dl);
[matches_cr, scores_cr] = vl_ubcmatch(dc, dr);




H12 = ransac(matches_cl, fc, fl, 100, 300);
H23 = ransac(matches_cr, fc, fr, 100, 300);


bbox = [-400 1200 -200 700];
reference_image = vgg_warp_H(single(center_image), eye(3), 'linear', bbox);
center_right = vgg_warp_H(single(right_image), H23, 'linear', bbox);
center_left = vgg_warp_H(single(left_image), H12, 'linear', bbox);

center_right_stitched = double(max(max(reference_image, center_left), center_right))/255;

imshow(center_right_stitched);


%imshow(center_right_stitched);



%max_H = ransac(matches_cr, fc, fr, 100, 300);

%bbox = [-400 1200 -200 700];
%reference_image = vgg_warp_H(single(center_image), eye(3), 'linear', bbox);
%compared_image = vgg_warp_H(single(right_image), max_H, 'linear', bbox);
%center_right_stitched = double(max(compared_image,reference_image))/255;



%[matches_cl, scores_cl] = vl_ubcmatch(dc, dl);
%max_H = ransac(matches_cl, fc, fl, 100, 300);

%bbox = [-400 1200 -200 700];
%reference_image = vgg_warp_H(single(center_image), eye(3), 'linear', bbox);
%compared_image = vgg_warp_H(single(left_image), max_H, 'linear', bbox);
%center_left_stitched = double(max(compared_image,reference_image))/255;
%imshow(center_left_stitched);





%[f_stiched, d_stitched] = vl_sift(single(rgb2gray(center_right_stitched)));
%[matches_final, scores_final] = vl_ubcmatch(d_stitched, dl);
%max_H = ransac(matches_final, f_stiched, fl, 100, 300);

%bbox = [-400 1200 -200 700];
%reference_image = vgg_warp_H(single(center_right_stitched), eye(3), 'linear', bbox);
%compared_image = vgg_warp_H(single(left_image), max_H, 'linear', bbox);
%aaa = double(max(compared_image,reference_image))/255;

%imshow(aaa);






%bbox = [-400 1200 -200 700];

%max_H_left = ransac(matches_cl, fc, fl, 100, 300);
%max_H_right = ransac(matches_cr, fc, fr, 100, 300);

%reference_image = vgg_warp_H(single(center_image), eye(3), 'linear', bbox);

%compared_image_right = vgg_warp_H(single(right_image), max_H_right, 'linear', bbox);
%center_right_stitched = double(max(compared_image_right,reference_image))/255;

%compared_image_left = vgg_warp_H(single(left_image), max_H_left, 'linear', bbox);
%center_left_stitched = double(max(compared_image_left,reference_image))/255;

%abc = double(max(center_left_stitched,center_right_stitched))/255;

%imshow(abc);










%bbox = [-400 1800 -200 700];

%max_H_left = ransac(matches_cl, fc, fl, 100, 300);
%first_reference = vgg_warp_H(single(center_image), eye(3), 'linear', bbox);
%compared_image_left = vgg_warp_H(single(left_image), max_H_left, 'linear', bbox);
%left_center_stitched = double(max(compared_image_left,first_reference))/255;

%imshow(left_center_stitched);


%[f_stitched, d_stitched] = vl_sift(single(rgb2gray(left_center_stitched)));
%[matches_stitched_right, scores_stitched_right] = vl_ubcmatch(d_stitched, dr);

%max_H_right = ransac(matches_stitched_right, f_stitched, fr, 100, 300);

%second_reference = vgg_warp_H(single(left_center_stitched), eye(3), 'linear', bbox);
%compared_image_right = vgg_warp_H(single(right_image), max_H_right, 'linear', bbox);
%final_stitched = double(max(compared_image_right,second_reference))/255;

%imagesc(final_stitched);

%max_H_right = ransac(matches_cr, fc, fr, 100, 300);




%compared_image_right = vgg_warp_H(single(right_image), max_H_right, 'linear', bbox);
%center_right_stitched = double(max(compared_image_right,reference_image))/255;

%compared_image_left = vgg_warp_H(single(left_image), max_H_left, 'linear', bbox);
%center_left_stitched = double(max(compared_image_left,reference_image))/255;

%abc = double(max(center_left_stitched,center_right_stitched))/255;

%imshow(abc);
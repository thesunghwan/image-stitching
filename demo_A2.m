run('~/MATLAB/vlfeat/toolbox/vl_setup');

left_image = imread('keble_a.jpg');
center_image = imread('keble_b.jpg');
right_image = imread('keble_c.jpg');

%show_images(left_image, center_image, right_image);

li_gray = rgb2gray(left_image);
ci_gray = rgb2gray(center_image);
ri_gray = rgb2gray(right_image);

[fl, dl] = vl_sift(single(ci_gray));
[fc, dc] = vl_sift(single(ci_gray));
[fr, dr] = vl_sift(single(ri_gray));

[matches_cl, scores_cl] = vl_ubcmatch(dc, dl);
[matches_cr, scores_cr] = vl_ubcmatch(dc, dr);





max_H = [];
max_vote = 0;

for m = 1:100
    positions_to_pick = randperm(size(matches_cr, 2), 4);
    four_random_matches = matches_cr(:, positions_to_pick);

    four_points_from_center = zeros(4, 2, 'double');
    four_points_from_right = zeros(4, 2, 'double');

    for n = 1:4
        four_points_from_center(n, :) = [fc(1, four_random_matches(1, n)) fc(2, four_random_matches(1, n))];
        four_points_from_right(n, :) = [fr(1, four_random_matches(2, n)) fr(2, four_random_matches(2, n))];
    end

    H = computeH(four_points_from_center, four_points_from_right);
    
    test_trial_number = 300;

    aaaaa = randperm(size(matches_cr, 2), test_trial_number);
    matched_pairs_to_test = matches_cr(:, aaaaa);


    vote = 0;
    for n = 1:test_trial_number
        pc = fc(1:2, matched_pairs_to_test(1, n));
        pr = [fr(1:2, matched_pairs_to_test(2, n)); 1];
        p_prime = H * pr;
        p_prime_scaled = [p_prime(1)/p_prime(3); p_prime(2)/p_prime(3)];

        distance = norm(pc - p_prime_scaled, 2);

        if distance < 3
            vote = vote + 1;
        end
    end
    
    if vote > max_vote
        max_vote = vote;
        max_H = H;
    end
end

bbox = [-400 1200 -200 700];
reference_image = vgg_warp_H(single(center_image), eye(3), 'linear', bbox);
compared_image = vgg_warp_H(single(right_image), max_H, 'linear', bbox);

imshow(double(max(compared_image,reference_image))/255);







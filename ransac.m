function result = ransac( matches_cr, fc, fr, ransac_count, inlier_count )
    max_H = [];
    max_vote = 0;

    for m = 1:ransac_count
        positions_to_pick = randperm(size(matches_cr, 2), 4);
        four_random_matches = matches_cr(:, positions_to_pick);

        four_points_from_center = zeros(4, 2, 'double');
        four_points_from_right = zeros(4, 2, 'double');

        for n = 1:4
            four_points_from_center(n, :) = fc(1:2, four_random_matches(1, n));
            four_points_from_right(n, :) = fr(1:2, four_random_matches(2, n));
        end

        H = computeH(four_points_from_center, four_points_from_right);

        test_trial_number = inlier_count;

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

    result = max_H;
end

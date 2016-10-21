function result = ransac( matches, reference_points, compared_points, ransac_count, inlier_count, error)
    max_H = [];
    max_vote = 0;

    for m = 1:ransac_count
        four_random_matches = matches(:, randperm(size(matches, 2), 4));

        four_points_in_reference = zeros(4, 2, 'double');
        four_points_in_compared = zeros(4, 2, 'double');

        for n = 1:4
            four_points_in_reference(n, :) = reference_points(1:2, four_random_matches(1, n));
            four_points_in_compared(n, :) = compared_points(1:2, four_random_matches(2, n));
        end

        H = computeH(four_points_in_reference, four_points_in_compared);

        test_trial_number = inlier_count;

        matched_pairs_to_test = matches(:, randperm(size(matches, 2), test_trial_number));

        vote = 0;
        for n = 1:test_trial_number
            pc = reference_points(1:2, matched_pairs_to_test(1, n));
            pr = [compared_points(1:2, matched_pairs_to_test(2, n)); 1];
            p_prime = H * pr;
            p_prime_scaled = [p_prime(1)/p_prime(3); p_prime(2)/p_prime(3)];

            distance = norm(pc - p_prime_scaled, 2);

            if distance < error
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


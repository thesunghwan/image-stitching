function matches = match_descriptors( reference_descriptors, comparison_descriptors, threshold)
    reference_descriptors = double(reference_descriptors);
    comparison_descriptors = double(comparison_descriptors);
    temp = [];
    
    for n = 1:size(reference_descriptors, 2)
        inital_distance = norm(reference_descriptors(:, n) - comparison_descriptors(:, 1), 2);
        best_min_distance_index = [n; 1];
        best_min_distance = 10000000;
        second_min_distance = inital_distance;
        
        for m = n:size(comparison_descriptors, 2)
            difference = reference_descriptors(:, n) - comparison_descriptors(:, m);
            distance = norm(difference, 2);
            if distance < best_min_distance
                second_min_distance = best_min_distance;
                best_min_distance = distance;
                best_min_distance_index = [n; m];
            end
        end
        ratio = second_min_distance / best_min_distance;
        if ratio >= threshold;
            temp = [temp best_min_distance_index];
        end
    end
    
    matches = temp;
end


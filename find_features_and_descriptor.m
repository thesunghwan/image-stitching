function [ features, descriptors ] = find_features_and_descriptor(detector_name, descriptor_name, gray_scale_image)
    if strcmp(detector_name, 'SIFT') && strcmp(descriptor_name, 'SIFT')
        [features, descriptors] = vl_sift(single(gray_scale_image));
    elseif strcmp(detector_name, 'harris corner') && strcmp(descriptor_name, 'template')
        %gray_scale_image = imgaussfilt(gray_scale_image,2);
        corners = detectHarrisFeatures(gray_scale_image);
        corners = corners.selectStrongest(300);
        points = transpose(corners.Location);
        features = [];
        descriptors = [];
        
        for n = 1:size(points, 2)
            point = points(:, n);
            
            left_top_margin = 9;
            right_bottom_margin = 10;
            
            y_top = int32(point(2, 1) - left_top_margin);
            y_bottom = int32(point(2, 1) + right_bottom_margin);
            x_left = int32(point(1, 1) - left_top_margin);
            x_right = int32(point(1, 1) + right_bottom_margin);
            
            
            if y_top > 0 && y_bottom < size(gray_scale_image, 1) && x_left > 0 && x_right < size(gray_scale_image, 2)
                patch = gray_scale_image(y_top:y_bottom, x_left:x_right);
                patch = patch(:);

                features = [features point];
                descriptors = [descriptors patch];
            end
        end
    elseif strcmp(detector_name, 'harris corner') && strcmp(descriptor_name, 'SIFT')
        corners = detectHarrisFeatures(gray_scale_image);
        corners = corners.selectStrongest(100);
        points = transpose(corners.Location);
        harris_features = [
            points;
            repmat(10,1,size(points, 2));
            zeros(1, size(points, 2));
        ];
        [features, descriptors] = vl_sift(single(gray_scale_image), 'frames', harris_features);
        %[features, descriptors] = vl_sift(single(gray_scale_image), 'frames', harris_features, 'orientations');
    else
        disp('The combination of detector and desriptor you provided is not allowed.');
    end
end


function [ features, descriptors ] = find_features_and_descriptor(detector_name, descriptor_name, gray_scale_image)
    if strcmp(detector_name, 'SIFT') && strcmp(descriptor_name, 'SIFT')
        [features, descriptors] = vl_sift(single(gray_scale_image));
        return;
    elseif strcmp(detector_name, 'harris corner') && strcmp(descriptor_name, 'SIFT')
        points = detectHarrisFeatures(gray_scale_image);
        points = transpose(points.Location);
        harris_features = [
            points;
            repmat(10,1,size(points, 2));
            zeros(1, size(points, 2));
        ];
        
        [features, descriptors] = vl_sift(single(gray_scale_image), 'frames', harris_features, 'orientations');
    else
        disp('The combination of detector and desriptor you provided is not allowed.');
    end
end


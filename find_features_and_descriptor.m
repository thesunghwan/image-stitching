function [ features, descriptors ] = find_features_and_descriptor(detector_name, descriptor_name, gray_scale_image)
    if strcmp(detector_name, 'SIFT') && strcmp(descriptor_name, 'SIFT')
        [features, descriptors] = vl_sift(single(gray_scale_image));
        return;
    end
end


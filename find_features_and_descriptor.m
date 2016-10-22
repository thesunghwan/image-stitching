function [ features, descriptors ] = find_features_and_descriptor(detector_name, descriptor_name, gray_scale_image)
    if strcmp(detector_name, 'SIFT') && strcmp(descriptor_name, 'SIFT')
        [features, descriptors] = vl_sift(single(gray_scale_image));
    elseif strcmp(detector_name, 'harris corner') && strcmp(descriptor_name, 'template')
        %gray_scale_image = imgaussfilt(gray_scale_image,2);
        corners = detectHarrisFeatures(gray_scale_image);
        corners = corners.selectStrongest(100);
        points = transpose(corners.Location);
        features = [];
        descriptors = [];
        
        for n = 1:size(points, 2)
            point = points(:, n);
            
            left_top_margin = 4;
            right_bottom_margin = 5;
            
            y_top = int32(point(2, 1) - left_top_margin);
            y_bottom = int32(point(2, 1) + right_bottom_margin);
            x_left = int32(point(1, 1) - left_top_margin);
            x_right = int32(point(1, 1) + right_bottom_margin);
            
            if y_top < 1
                diff = abs(1 - y_top);
                y_top = 1;
                y_bottom = y_bottom + diff;
            end
            %disp('y_top adjusted');
            %disp(y_top);
            %disp(y_bottom);
            
            if y_bottom > size(gray_scale_image, 1)
                diff = abs(y_bottom - size(gray_scale_image, 1));
                y_top = y_top - diff;
                y_bottom = y_bottom - diff;
            end
            %disp('y_bottom adjusted');
            %disp(y_top);
            %disp(y_bottom);
            
            if x_left < 1
                diff = abs(1 - x_left);
                x_left = 1;
                x_right = x_right + diff;
            end
            %disp('x_left adjusted');
            %disp(x_left);
            %disp(x_right);
            
            if x_right > size(gray_scale_image, 2)
                diff = abs(x_right - size(gray_scale_image, 2));
                x_left = x_left - diff;
                x_right = x_right - diff;
            end
            %disp('x_right adjusted');
            %disp(x_left);
            %disp(x_right);
            
            %if y_top > 0 && y_bottom < size(gray_scale_image, 1) && x_left > 0 && x_right < size(gray_scale_image, 2)
                patch = gray_scale_image(y_top:y_bottom, x_left:x_right);
                patch = patch(:);

                features = [features point];
                descriptors = [descriptors patch];
            %end
        end
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


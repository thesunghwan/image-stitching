function [ li_features, ci_features, ri_features ] = detect_features( li_gray, ci_gray, ri_gray )
    li_features = detectHarrisFeatures(li_gray);
    ci_features = detectHarrisFeatures(li_gray);
    ri_features = detectHarrisFeatures(li_gray);
end


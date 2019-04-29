function [ distinctIntensityVal intensityDensityFn ] = IntensityDensityEstimate( I,h )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    I                   = double(I);
    [r c]               = size(I);
    intensityArray      = I(:);
    imageLength         = length(intensityArray);
    distinctIntensityVal= unique(intensityArray);
    noOfintensityVal    =length(distinctIntensityVal);
    [ imageHistogram ]  = histigramCalc( I );
%     h                   = 20;
    intensityRange      = 0:1:255;
    diffInIntensity     = 0:1:255;
    exponentLookup      = exp(-1*(diffInIntensity.*diffInIntensity)./(2*h*h));
    intensityDensityFn  = zeros(1,noOfintensityVal);

    for i=1:1:noOfintensityVal
        for j=1:1:noOfintensityVal
            intensityDensityFn(i)= intensityDensityFn(i)+imageHistogram(2,distinctIntensityVal(j)+1)*(exponentLookup(abs(distinctIntensityVal(i)-distinctIntensityVal(j))+1));
        end
    end


end


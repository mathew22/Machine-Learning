function [ newSample ] = boundCheck(newSample, sMin,sMax )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    if newSample(1)<sMin(1)
        newSample(1)=sMin(1);
    elseif newSample(1)>sMax(1)
        newSample(1)=sMax(1);
    end
    if newSample(2)<sMin(2)
        newSample(1)=sMin(2);
    elseif newSample(2)>sMax(2)
        newSample(2)=sMax(2);
    end

end


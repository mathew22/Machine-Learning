function [ newSample ] = boundCheck(newSample, sMin,sMax )
%This function checks wheteher theinput vector is  withi the limits
%specified in sMin and sMAx. If the vector is found to be beyond the limit
%specified limits then they will be replaced with the boundary values
%   Detailed explanation goes here
    
%     s=size(newPoint);
%     n1=newPoint(1,2:s(2));
%     n2=newPoint(1,2:s(2));
%     n1=bi2de
    %Check along the first dimension
    if newSample(1)<sMin(1)
        newSample(1)=sMin(1);
    elseif newSample(1)>sMax(1)
        newSample(1)=sMax(1);
    end
    %Check along the second dimension
    if newSample(2)<sMin(2)
        newSample(1)=sMin(2);
    elseif newSample(2)>sMax(2)
        newSample(2)=sMax(2);
    end

end


function [ yNew ] = YOutlierCheck( randY,yValNoNoise,yVal,yMinLimit,yMaxLimit,k )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    while (randY-yValNoNoise)>k*yVal
        randY=generatePopulation( yMinLimit,yMaxLimit,1 );
    end
    yNew=randY;
end


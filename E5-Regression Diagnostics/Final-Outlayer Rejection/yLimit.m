function [ yMinLimit,yMaxLimit ] = yLimit( yVal )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    yMax=max(yVal);
    yMin=min(yVal);
    yRange=yMax-yMin;
    yMedian=(yMax+yMin)/2;
    yMinLimit=yMedian-yRange;
    yMaxLimit=yMedian+yRange;
end


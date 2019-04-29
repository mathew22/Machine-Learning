function [ scaledPoints ] = scaleDimension( points,minVal,maxVal )
%UNTITLED3 Summary of this function goes here
%Converts the given set of points into the range specified by minVal and maxVal
%Input Variables
%   points->one dimensional set of points
%   minVal->min value of the output data range
%   maxVal->maximum value of the output data range
% Output variables
%   scaledPoints->the points converted to the new range
% Eg:-scaleDimension( [1 2 3 4 5],-1,1 )
%-----------------------------------------------
%Developed by:Mathew Francis
%Revision History:
%   Initial Draft:1-11-2014
%
% ------------------------------------------------
   if length(points)>=2
        minPoint=min(points);
        maxPoint=max(points);
        scaledPoints=((points-minPoint)*(maxVal-minVal)/(maxPoint-minPoint))+minVal;
   else
        error('Atleast two data points are required for executing the program');
    end
end


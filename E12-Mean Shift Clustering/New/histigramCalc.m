function [ imageHistogram ] = histigramCalc( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    I                       = double(I);
    [r c]                   = size(I);
    imageHistogram          = zeros(2,256);
    imageHistogram(1,:)     = 0:1:255;
    for i=1:1:r
        for j=1:1:c
            imageHistogram(2,(I(i,j)+1))=imageHistogram(2,(I(i,j)+1))+1;
        end
    end


end


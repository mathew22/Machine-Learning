function [ yVal ] = genOutliers( yVal,fracOfOutliers,yMinLimit,yMaxLimit )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    tmp=yVal;
    l=length(yVal);
    noOfOutliers=ceil(l*fracOfOutliers);
    
    noOfDistinctIndexes=0;
    while noOfDistinctIndexes~=noOfOutliers             %Checking for different indexes
%         outlierPointIndex=randi(l,1,noOfOutliers);
        outlierPointIndex=randperm(l,noOfOutliers);
        differentIndexesCheck=unique(outlierPointIndex);
        noOfDistinctIndexes=length(differentIndexesCheck);
    end
    randYValues  = generatePopulation( yMinLimit,yMaxLimit,l );
     for i=1:1:noOfOutliers
         yVal(outlierPointIndex(i))=randYValues(outlierPointIndex(i));
     end
end


function [ yVal ] = genOutliers( yValNoNoise,yVal,fracOfOutliers,yMinLimit,yMaxLimit )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    tmp=yVal;
    l=length(yVal);
    noOfOutliers=ceil(l*fracOfOutliers);
    
    noOfDistinctIndexes=0;
    while noOfDistinctIndexes~=noOfOutliers             %Checking for different indexes
%         outlierPointIndex=randi(l,1,noOfOutliers);      %This check might result in an infinite loop if no of outliers is large.
        outlierPointIndex=randperm(l,noOfOutliers);
        differentIndexesCheck=unique(outlierPointIndex);
        noOfDistinctIndexes=length(differentIndexesCheck);
    end
    randYValues  = generatePopulation( yMinLimit,yMaxLimit,l );

%     
%     meanY=mean(yVal);
%     yTmp=yVal-repmat(meanY,1,l);
%     sigma=std(yTmp);
    k=.4;
     for i=1:1:noOfOutliers
         %This following if condition is used to check whether any of the
         %randomly generated points has become inliers instead of outliers
%         if
%         abs(randYValues(outlierPointIndex(i))-yValNoNoise(outlierPointIndex(i)))<k*yVal(outlierPointIndex(i))  
%             randYValues(outlierPointIndex(i))=YOutlierCheck(randYValues(outlierPointIndex(i)),yValNoNoise(outlierPointIndex(i)),yVal(outlierPointIndex(i)),yMinLimit,yMaxLimit,k);
%             yVal(outlierPointIndex(i))=randYValues(outlierPointIndex(i));
%         else
            yVal(outlierPointIndex(i))=randYValues(outlierPointIndex(i));
%         end
% 
     end
end


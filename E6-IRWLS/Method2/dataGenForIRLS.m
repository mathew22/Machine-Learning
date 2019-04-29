function [xVal,yValNoNOise,yValNoise,yValWithOutliers,weight  ] = dataGenForIRLS( xMin,xMax,noOfPoints,a,b,fracOfOutliers )
%Generates the two dimensional data for te IRLS algorithm
%   Detailed explanation goes here

    weight=repmat(1/noOfPoints,1,noOfPoints);   %Same weight for all
%     Random x values
%     [ population ] = generatePopulation( xMin,xMax,noOfPoints-2 );   %-2 as the lower and upper values are thw min and max values
    delta=(xMax-xMin)/(noOfPoints-1);       %x values with uniform interval
    xVal=xMin:delta:xMax;
%     xVal=[xMin population xMax];
    xVal=sort(xVal,'ascend');
    [ yValNoNOise ] = evalY( xVal,a,b,0,0);
    [ yValNoise ] = evalY( xVal,a,b,0,1);       %evalY( xVal,a,b,mu,sigma);
    [ yMinLimit,yMaxLimit ] = yLimit( yValNoise );
    yValWithOutliers =  genOutliers( yValNoise,fracOfOutliers,yMinLimit,yMaxLimit );
    
end


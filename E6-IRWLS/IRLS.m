function [  ] = IRLS( xMin,xMax,noOfPoints,a,b,fracOfOutliers,w,maxItr )
%   y=ax+b
%   Uncomment lines 8 and 11 and comment 9 and 10 to get a random selection
%   of points in the x interval.(otherwise uniform points are considered)
%    IRLS( 1,20,35,3,3,.42,1,30 )  
    weight=repmat(1/noOfPoints,1,noOfPoints); %initial value for the weights
    %Random x values
%     [ population ] = generatePopulation( xMin,xMax,noOfPoints-2 );   %-2 as the lower and upper values are thw min and max values
    delta=(xMax-xMin)/(noOfPoints-1);       %x values with uniform interval
    xVal=xMin:delta:xMax;
%     xVal=[xMin population xMax];
    xVal=sort(xVal,'ascend');
    [ yValNoNOise ] = evalY( xVal,a,b,0,0);
    [ yVal ] = evalY( xVal,a,b,1,2);       %evalY( xVal,a,b,mu,sigma);
    [ yMinLimit,yMaxLimit ] = yLimit( yVal );
    yValWithOutliers =  genOutliers( yVal,fracOfOutliers,yMinLimit,yMaxLimit );
    color='ymcg';
    plot(xVal,yVal,'b');
    hold on;
    pause(2);
    scatter(xVal,yValWithOutliers,'b');
    pause(2);
    
%----Stage 2-estimating a nd b and calculating the errors------
    p=1;
    for i=1:1:maxItr
        %[ aCap,bCap,yEstimated1 ] = lineFitting( xVal,yValWithOutliers );
        [ aCap,bCap] = weightedLineFitting( weight,xVal,yValWithOutliers );
        [ yEstimated ] = evalY( xVal,aCap,bCap,0,0);
        plot(xVal,yEstimated,color(p));
        pause(2);
        
        error=yValWithOutliers-yEstimated;%yvalwithOutliers  or without noise
%         error=abs(error);
        E=sum(weight.*(error.*error));
        if E<10^-4
            break;
        end
        u=1./error;
        u=abs(u);
        weight=u/sum(u);
        
        p=p+1;
        if p==4
            p=1;
        end
    end
    figure;
    scatter(xVal,yValWithOutliers);
    hold on;
    plot(xVal,yEstimated,'k');
    title('IRWLS Algorithm');
end


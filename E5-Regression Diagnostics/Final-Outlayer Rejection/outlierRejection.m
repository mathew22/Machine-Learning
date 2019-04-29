function [ count aCap bCap MSE ] = outlierRejection( xMin,xMax,noOfPoints,a,b,fracOfOutliers,k,maxItr )
%UNTITLED4 Summary of this function goes here
%    outlierRejection( 1,20,35,3,3,.46,1,30 )

    weight=repmat(1/noOfPoints,1,noOfPoints); %initial value for the weights
    %Random x values
%     [ population ] = generatePopulation( xMin,xMax,noOfPoints-2 );   %-2 as the lower and upper values are thw min and max values
    delta=(xMax-xMin)/(noOfPoints-1);       %x values with uniform interval
    xVal=xMin:delta:xMax;
    xTemp=xVal;
%     xVal=[xMin population xMax];
    xVal=sort(xVal,'ascend');
    yValNoNoise=evalY( xVal,a,b,0,0); 
    [ yVal ] = evalY( xVal,a,b,1,1);       %evalY( xVal,a,b,mu,sigma);
    [ yMinLimit,yMaxLimit ] = yLimit( yVal );
    yValWithOutliers =  genOutliers(yValNoNoise, yVal,fracOfOutliers,yMinLimit,yMaxLimit );
    color='ymcg';
    f=scatter(xVal,yVal,'k');
    pause(2);
    hold on;
%     plot(xVal,yVal,'k');
%     pause(2);
%     b= scatter(xVal,yValWithOutliers,'r');
%      pause(2);


% [ x,y ] = createPointsForRegression( m,c,xmin,xmax,mu,sigma,N);
%     l=length(x);
%     hold all;
%     color='rgcmy';
    p=1;
    delete(f);
    h=scatter(xVal,yValWithOutliers,'b');
    pause(2);
    count=0;
    for i=1:1:maxItr
        
        
%         h=scatter(xVal,yValWithOutliers,'b');
%         pause(2);
        [ aCap,bCap ] = lineFitting( xVal,yValWithOutliers );
        [ yEstimated ] = evalY( xVal,aCap,bCap,0,0);    %zeos are passed as the mean and sd as there is no need to add noise in here.For more clarity check the code for the function.
        h1=plot(xVal,yEstimated,'b');
        pause(2);
%         delete(h1);
%         delete(h);
        [ newX newY rejX rejY] = selectInline( xVal,yValWithOutliers,yEstimated,k );
        h=scatter(rejX, rejY,'r');
        pause(2);
        count=count+1;
        
        if length(newX)<=ceil(noOfPoints*(1-fracOfOutliers));
            break;
        end
%         if std(newY)<=1.1*std(yVal);
%             break;
%         end

        xVal=newX;
        yValWithOutliers=newY;
        p=p+1;
        if p==5
            p=1;
        end
        
    end
    [ yEstimated ] = evalY( xTemp,aCap,bCap,0,0);  
    error=yEstimated-yValNoNoise;      %Is it yVal or yValNoNoise
    MSE=sum(error.*error);
    plot(xTemp,yEstimated,'k');
    title('Outlier Rejection');
end


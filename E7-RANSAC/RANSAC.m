function [ aCap,bCap,count, E] = RANSAC( xMin,xMax,noOfPoints,a,b,fracOfOutliers,k,noOfModelParam)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   RANSAC( -100,100,150,01,1,.3,1,10 )

    %     [ population ] = generatePopulation( xMin,xMax,noOfPoints-2 );   %-2 as the lower and upper values are thw min and max values
    delta=(xMax-xMin)/(noOfPoints-1);       %x values with uniform interval
    xVal=xMin:delta:xMax;
%     xVal=[xMin population xMax];
    xVal=sort(xVal,'ascend');
    [ yValNoNoise ] = evalY( xVal,a,b,0,0);
    [ yVal ] = evalY( xVal,a,b,1,5);       %evalY( xVal,a,b,mu,sigma);
    [ yMinLimit,yMaxLimit ] = yLimit( yVal );
    yValWithOutliers =  genOutliers( yVal,fracOfOutliers,yMinLimit,yMaxLimit );
    color='ymcg';
    h1=plot(xVal,yVal,'b');
    title('RANSAC Algorithm');
    hold on;
%     pause(2);
    h2=scatter(xVal,yValWithOutliers,'b');
%     pause(2);
%     q=1;
    p=1;
    modeldata(1,1)=0;
    modeldata(2,1)=0;
    modeldata(3,1)=0;
    maxItr =ceil(3*((1-fracOfOutliers)^(-1*noOfModelParam)));
    bestModel=zeros(3,1);
    count=0;
    for i=1:1:maxItr
        [ xMVal yMVal ] = selectMPoints( xVal,yValWithOutliers,noOfModelParam );
        hs=scatter(xMVal,yMVal,color(p));
%         pause(2);
        [ aCap,bCap] = lineFitting( xMVal,yMVal );
        [ yEstimated ] = evalY( xVal,aCap,bCap,0,0);    %zeos are passed as the mean and sd as there is no need to add noise in here.For more clarity check the code for the function.
        hp=plot(xVal,yEstimated,color(p));
%         pause(2);
        
 	% Error abs( actual -estimated value)
        error=yVal-yEstimated;
	% mean of error
        meanE=mean(error);
	
	% Standard deviation of error
        sdE=std(error);
%         error=abs(error);
        noOfInliers=0;
        for r=1:1:noOfPoints
            if abs(error(r)-meanE)<k*sdE;
                noOfInliers=noOfInliers+1;
            end
        end
        modeldata(1,i)=noOfInliers;
        modeldata(2,i)=aCap;
        modeldata(3,i)=bCap;
        
        if modeldata(1,i)>bestModel(1,1)
            bestModel(1,1)=modeldata(1,i);
            bestModel(2,1)=modeldata(2,i);
            bestModel(3,1)=modeldata(3,i);
        end
%         q=q+1;
        count=count+1;
        E=sum((error.*error));
        if E<10^-4
            break;
        end
%         delete(hs);
%         delete(hp);
        p=p+1;
        if p==4
            p=1;
        end
    end
    figure;plot(xVal,yValNoNoise,'g');
    hold on;
    scatter(xVal,yValWithOutliers,'b');
    [ yEstimated ] = evalY( xVal,bestModel(2,1),bestModel(3,1),0,0);
    plot(xVal,yEstimated,'k');
    legend('Model data with normal noise','Data with outliers','Estimated line');
    title('RANSAC Algorithm');
    %      pause(2);
     k=1;
%      
%      for i=1:10:maxItr
%         inlierCount(k)=max(modeldata(1,1:i));
%         k=k+1;
%      end
%      index=1:10:maxItr;
%      figure;plot(index*10,inlierCount);
%      xlabel('no of iterations');
%      ylabel('max no of inliers');
end


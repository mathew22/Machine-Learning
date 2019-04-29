function [ newX newY ] = selectInline( x,y,yEstimated,k )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%     yEstimated=a*x2+b;
%     h1=plot(x,yEstimated,'r');
    error=y-yEstimated;
    mu=mean(error);
    sd=std(error);
    th=k*sd;
    p=1;
    errorMeanSubtracted=error-repmat(mu,1,length(error));
    errorMeanSubtracted=abs(errorMeanSubtracted);
    for i=1:1:length(error)
        if errorMeanSubtracted(i)<=th
            newX(p)=x(i);
            newY(p)=y(i);
            p=p+1;
        end
    end
end


function [ a,b] = weightedLineFitting( weight,x,y )
%This program fits a line for the given input points x1,y1

    % N=length(x);
    XX=x.*x;
    WXX=weight.*XX;
    sumWXX=sum(WXX);

    WY=weight.*y;
    sumWY=sum(WY);

    WX=weight.*x;
    sumWX=sum(WX);

    XY=x.*y;
    WXY=weight.*XY;
    sumWXY=sum(WXY);

    sumW=sum(weight);

    % sum_y=sum(y);
   

    % a=(N*sum_xy-sum_x*sum_y)/(N*sum_xx-sum_x*sum_x);    %Formula to calculate the slope
    % b=(sum_y-a*sum_x)/N;                                %Formula to calculate the displacement constant

    a=(sumW*sumWXY-sumWX*sumWY)/(sumW*sumWXX-(sumWX)^2);
    b=(sumWXX*sumWY-sumWX*sumWXY)/(sumW*sumWXX-(sumWX)^2);
    yEstimated=a*x+b;
    % plot(x1,yEstimated,'r');
end


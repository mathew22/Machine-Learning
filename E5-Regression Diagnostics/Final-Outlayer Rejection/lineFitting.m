function [ a,b ] = lineFitting( x1,y1 )
%This program fits a line for the given input points x1,y1


    N=length(x1);
    sum_x=sum(x1);
    sum_y=sum(y1);
    xx=x1.*x1;
    yy=y1.*y1;
    xy=x1.*y1 ;

    sum_xx=sum(xx);
    sum_yy=sum(yy);
    sum_xy=sum(xy);

    a=(N*sum_xy-sum_x*sum_y)/(N*sum_xx-sum_x*sum_x);    %Formula to calculate the slope
    b=(sum_y-a*sum_x)/N;                                %Formula to calculate the displacement constant

     yEstimated=a*x1+b;
%     plot(x1,y_estimated,'r');
end


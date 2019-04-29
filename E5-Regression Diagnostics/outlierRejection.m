function [  ] = outlierRejection( m,c,xmin,xmax,mu,sigma,N,k,maxItr )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    [ x,y ] = createPointsForRegression( m,c,xmin,xmax,mu,sigma,N);
    l=length(x);
    hold all;
    color='rgcmy';
    p=1;
    for i=1:1:maxItr
        h=scatter(x,y);
        pause(2);
        [ yEstimated ] = lineFitting( x,y );
        h1=plot(x,yEstimated,color(p));
        pause(2);
%         delete(h1);
%         delete(h);
        [ newX newY ] = selectInline( x,y,yEstimated,k );
        
        if length(newX)<=l/2;
            break;
        end
        x=newX;
        y=newY;
        p=p+1;
        if p==5
            p=1;
        end
    end
    
    plot(x,yEstimated,'k');
end


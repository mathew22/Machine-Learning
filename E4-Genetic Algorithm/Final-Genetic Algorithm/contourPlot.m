function [  ] = contourPlot( sMin,sMax,muX,muY,sigmaX,sigmaY,noOfPoints )
%Performs the contour plot of the function Z
%   Detailed explanation goes here

    xMin=sMin(1);
    xMax=sMax(1);
    
    yMin=sMin(2);
    yMax=sMax(2);
    
    stepSizeX=(xMax-xMin)/(noOfPoints-1);        %step size along the x axis for creating the N points.N-1 is used so as to avoid the additional point coming when N is used
    stepSizeY=(yMax-yMin)/(noOfPoints-1);
    
    x=xMin:stepSizeX:xMax;              %Range of values for x
    y=yMin:stepSizeY:yMax;                                    %Range of values for y
   
    x1=(x-muX)/sigmaX;
    y1=(y-muY)/sigmaY;
    [X,Y]=meshgrid(x1,y1);
    z=(X).^2+(Y).^2;
    
    contour(x,y,z,50)


end


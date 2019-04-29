function [ output_args ] = plotCalc( muX,muY,sigmaX,sigmaY)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%     muX=5;
%     muY=5;
%     sigmaX=4;
%     sigmaY=1;
    lambdaX=sigmaX^2;
    lambdaY=sigmaY^2;
    N=30;
    
    R=[cos(pi/3)  -1*sin(pi/3);sin(pi/3) cos(pi/3)];    %Rotation Matrix
    newX=R*[1;0];       %Rotated X axis              
    newY=R*[0;1];
    basis=[newX,newY];
    lambda=[lambdaX 0 ; 0 lambdaY];
    covMatrix=lambda*basis*(inv(basis));
    %or covMatrix=[sigmaX 0;0 sigmaY];
    covMatrix1=basis*covMatrix*inv(basis);
    a=sqrt(lambdaX);      %major axis
    b=sqrt(lambdaY);      %minor axis
%     x=zeros(1,N);
%     for i=1:1:N
%         alpha=rand(1);
%         x(i)=alpha*(muX-sigmaX)+(1-alpha)*(muX+sigmaX);
%         x1(i)=normrnd(muX,sigmaX);
%     end
%     x=normrnd(muX,sigmaX,1,N);
%     y=normrnd(muY,sigmaY,1,N);
    xMin=muX-sigmaX;
    xMax=muX+sigmaX;
    
    yMin=muY-sigmaY;
    yMax=muY+sigmaY;
    
    stepSizeX=(xMax-xMin)/(N-1);        %step size along the x axis for creating the N points.N-1 is used so as to avoid the additional point coming when N is used
    stepSizeY=(yMax-yMin)/(N-1);
    
    x=xMin:stepSizeX:xMax;              %Range of values for x
    y=yMin:stepSizeY:yMax;                                    %Range of values for y
   
    x1=(x-muX)/sigmaX;
    y1=(y-muY)/sigmaY;
    [X,Y]=meshgrid(x1,y1);
    z=exp((-1*((X).^2+(Y).^2)))/(2*pi*sigmaX*sigmaY)^0.5;
%     z1=(exp((-1*z)))/(2*pi*sigmaX*sigmaY)^0.5;
%     figure;imshow(z,[]);
    figure;contour(X,Y,z,100)
    view(0,30);
%     axis([-6 6 -6 6]);
%     [X,Y]=meshgrid(x,y);
%     z=((X-muX)/a).^2+((Y-muY)/b).^2;
%     contour(X,Y,z,100)
    
    v=[x1 ;y1];
    vRotated=R*v;
    x2=(vRotated(1,:)-0)/sigmaX;
    y2=(vRotated(2,:)-0)/sigmaY;
    [X1,Y1]=meshgrid(x2,y2);
    z1=(X1).^2+(Y1).^2;
    figure;
    hold on;contour(X,Y,z1,100)
end


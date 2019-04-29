function [ x,y,z ] = contour_plot( muX,muY,sigmaX,sigmaY,N)
%UNTITLED4 Summary of this function goes here
%  Eg:- [ x,y,z ] = contour_plot( 0,0,1,1,25)
    xMin=muX-4*sigmaX;
    xMax=muX+4*sigmaX;
    
    yMin=muY-4*sigmaY;
    yMax=muY+4*sigmaY;
    
    stepSizeX=(xMax-xMin)/(N-1);        %step size along the x axis for creating the N points.N-1 is used so as to avoid the additional point coming when N is used
    stepSizeY=(yMax-yMin)/(N-1);
    
    x=xMin:stepSizeX:xMax;              %Range of values for x
    y=yMin:stepSizeY:yMax;                                    %Range of values for y
   
    x1=(x-muX)/sigmaX;
    y1=(y-muY)/sigmaY;
    [X,Y]=meshgrid(x1,y1);
    z=(X).^2+(Y).^2;
    
    contour(x,y,z,50)
%    v_min=[xmax;ymax];                      %starting point for gradient descent
%    theta=0.2;                              %constant for gradient descent
%     gradient_values_y=diff(y)./diff(x);
%     gradient_values_x=diff(x)./diff(y);
%     for i=1:1:25
%        grad_x=gradient_values_x(find(x==v_min(1))-1);
%        grad_y=gradient_values_y(find(y==v_min(2))-1);
%        % v_min=v_min-theta*gradient
%        v_min=v_min-theta*[grad_x;grad_y];
%     end        
       % v_min
    hold on;
    
    %-------Gradient Descent algorithm starts here
%     maxItr=250;
%     point=[xMax;yMax];
%     mu=[muX;muY];
%     sigma=[sigmaX^2 0;0 sigmaY^2];
%     alpha=rand(1,2);%[.02;.03];
%     %alpha=[0.5,0.3];
%     alpha=alpha';
%     %track=zeros(2,itr);
%     for itr=1:1:maxItr
%         track(:,itr)=point;
%         gradient=2*(inv(sigma))*(point-mu);
%         newPoint=point-alpha.*gradient;
%         
%         if abs(newPoint-point)<10^-6                %condition to break the iterations
%               break;
%         end
%         gradientNewPoint=2*(inv(sigma))*(newPoint-mu);
%         gradDifference=sign(gradient)-sign(gradientNewPoint);
%         if sum(gradDifference)==0;              %check for a change in the gradient sign and ifso modify the value of alpha
%          point=newPoint;
%         else
%             alpha=alpha/2;
%         end
%     end
%     
%     scatter(track(1,:),track(2,:));
%     plot(track(1,:),track(2,:));
end


function [ track ] = gradientDescent( x,y,muX,muY,sigmaX,sigmaY,maxItr) 
%This  function does the gradient search to find the minimum point(2
%dimensional)
%   x,y-> array for the points which is already defined inthe contour plot
%   function
%   muX,muY-> mean avlue across each o the dimension
%   sigmaX,sigmaY-> sd across the dmensions
%   maxItr-> maximum iterations for  the algorithm
%Eg:-   [ x,y,z ] = contour_plot( 0,0,1,1,25)
%       hold on;
%       gradientDescent( x,y,0,0,1,1,25)

    point=[max(x);max(y)];
    mu=[muX;muY];
    sigma=[sigmaX^2 0;0 sigmaY^2];
    alpha=rand(1,2);%[.02;.03];             %this random vector is used to generate the co-ordinates of the next generation
    %alpha=[0.5,0.3];
    alpha=alpha';
    %track=zeros(2,itr);
    for itr=1:1:maxItr
        track(:,itr)=point;                %holds the value of the point in each iteration.Used to plot the path of gradient descent.
        gradient=2*(inv(sigma))*(point-mu);%calculation of the gradient(derivative of the given function across the dimensions)
        newPoint=point-alpha.*gradient;
        
        if abs(newPoint-point)<10^-6                %condition to break the iterations if thereis negligible difference between the iterations
              break;
        end
        gradientNewPoint=2*(inv(sigma))*(newPoint-mu);
        gradDifference=sign(gradient)-sign(gradientNewPoint);
%         if sum(gradDifference)==0;              %check for a change in the gradient sign and if so modify the value of alpha(sign change indicates that the point hasjumped for one side of the geraph to the other side.This happens because the step size for the next iteration is large. To remove this reduce the value of alpha to redue the stepsize.
        if (gradDifference(1,1)==0 &&   gradDifference(2,1)==0  )
            point=newPoint;                        %update the point only if it is moving in the gradient direction
        else
            alpha=alpha/2;%?changes alpha for both dimensions but the alpha corresponding to the dimension of the gradient change only need to be changed.
        end
    end
    
    % scatter plot of one point at a time
    for i=1:1:size( track,2 )
        scatter( track(1,i) ,track(2,i), 'r');
        pause( 1)
    end
    
        
    scatter(track(1,:),track(2,:));
    plot(track(1,:),track(2,:));
    
%   hold on;
%     %maxItr=500;
%     point=[xMax;yMax];
%     mu=[muX;muY];
%     sigma=[sigmaX^2 0;0 sigmaY^2];
%     alpha=rand(1,2);%[.02;.03];
%     alpha=alpha';
%     track=zeros(2,maxItr);
%     for itr=1:1:maxItr
%         track(:,itr)=point;
%         gradient=2*(inv(sigma))*(point-mu);
%         newPoint=point-alpha.*gradient;
%         point=newPoint;
%         
%     end
%     scatter(track(1,:),track(2,:));
%     plot(track(1,:),track(2,:));
end


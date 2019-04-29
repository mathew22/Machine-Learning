function [ aCap,bCap ] = lineFitGradientDesc( xData,yValNoNOise,yData, weight, a0,b0 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    xVal=xData;
    yValWithOutliers=yData;
%     yEstimated= evalY( xVal,a0,b0,0,0);
%     error=yValWithOutliers-yEstimated;
%     MSE=sum((error.*error).*weight);
    alpha=rand(1,2);
    alpha=alpha';
    vector=[a0;b0];
    maxItr=500;
%     weightItr=zeros(maxItr,60);
    aGDItr=zeros(maxItr,1);
    bGDItr=zeros(maxItr,1);
 for itr=1:1:maxItr
%         track(:,itr)=point;                %holds the value of the point in each iteration.Used to plot the path of gradient descent.
        yEstimated= evalY( xVal,a0,b0,0,0);
        error=yValWithOutliers-yEstimated;%fits to the data with outliers

%         error=yValNoNOise-yEstimated;    % If u use this it will fit to
%         the model line
%         error=yValWithOutliers-yEstimated;  % will fit to the noisy line
        gradA=-1*2*sum(weight.*(error.*xVal));
        gradB=-1*2*sum(weight.*error);
        
        gradient=[gradA;gradB];
                
        newVector=vector-2*alpha.*gradient;
        
        if abs(newVector-vector)<10^-2                %condition to break the iterations if thereis negligible difference between the iterations
              break;
        end
        
        yEstimated1= evalY( xVal,newVector(1,1),newVector(2,1),0,0);
%         error1=yValWithOutliers-yEstimated1;
        error1=yValNoNOise-yEstimated1;
        gradientNewVectorA=-1*2*sum(weight.*(error1.*xVal));
        gradientNewVectorB=-1*2*sum(weight.*error1);
        gradientNewPoint=[gradientNewVectorA;gradientNewVectorB];
        
        gradDifference=sign(gradient)-sign(gradientNewPoint);
%         z=[0;0];
        if (gradDifference(1,1)==0 &&   gradDifference(2,1)==0  )         %check for a change in the gradient sign and if so modify the value of alpha(sign change indicates that the point hasjumped for one side of the geraph to the other side.This happens because the step size for the next iteration is large. To remove this reduce the value of alpha to redue the stepsize.
         vector=newVector;  %update the point only if it is moving in the gradient direction
         error=error1;
         aGDItr(itr)=vector(1,1);
         bGDItr(itr)=vector(2,1);
        else
            alpha=alpha/2;%?changes alpha for both dimensions but the alpha corresponding to the dimension of the gradient change only need to be changed.
        end
%         vector=newVector;
%         u=1./(error+.01);
%         u=abs(u);
%         weight=u/sum(u);
%         E=sum(weight.*(error.*error));
% %         weightItr(i,:)=weight(1,:);
%           aItr(i,1)=aCap;
%           bItr(i,1)=bCap;  
end
    aCap=vector(1,1);
    bCap=vector(2,1);
    

end


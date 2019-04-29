
% Program to compute the perceptron model for classifying the data

clear all;
r1              = 0;            %RAdius for first set of data points
N               = 200;          %No of data points
r2              = 7;           %%RAdius for second set of data points
centroid1       = [-5;5];     %Centroid of first set of data
centroid2       = [5;-5];     %Centroid of second set of data
label1          = zeros(N,1);
label2          = ones(N,1);
label1          = label1+0.1;  %Label for negative samples
label2          = label2+0.9;  %Label for positive samples

%--------------Generate the data points-----------------
[ pointsSet1 ]  = genrandomPoints( r1,r2,N,centroid1  );
[ pointsSet2 ]  = genrandomPoints( r1,r2,N,centroid2  );
points          = [pointsSet1';pointsSet2'];%Dataset of positve and negative points
scatter(pointsSet1(1,:),pointsSet1(2,:),'r');
hold on;
scatter(pointsSet2(1,:),pointsSet2(2,:),'b');
legend('label1','label2');
hold off;
%------------------------------------------------------------

%-----------------Scaling across different dimension-----------

minVal          = -1;           %Minimumm value of the traget range
maxVal          = 1;            %Maximum value of the target range

% Scaling the data across the dimensions
[ scaledPointsDim1 ]    = scaleDimension( points(:,1),minVal,maxVal );
[ scaledPointsDim2 ]    = scaleDimension( points(:,2),minVal,maxVal );
label                   = [label1; label2];
% 
% pointsSet1WithLabel=[scaledPointsDim1 label1];
% pointsSet2WithLabel2=[scaledPointsDim2 label2];
pointswithLabel         = [scaledPointsDim1 scaledPointsDim2 label];

figure;
scatter(pointswithLabel(1:N,1),pointswithLabel(1:N,2),'r');
hold on;
scatter(pointswithLabel(N+1:N+N,1),pointswithLabel(N+1:N+N,2),'b');
legend('label1','label2');
%------------------------------------------------------------

%-----------initialize the parameters-----------------------
% Initialize weights i.e taking the worst solution as the starting solution(line joining -10,10, and 10,-10)
%Even if the points are scales to new range the line through centroid will
%have the samre equations. y=-x+0 is the equatio of the line passing
%hrough(-10,10) and (10,-10) ie x+y=0=>w1=1 w2=1,b=0;


slope   = (centroid2(2,1)-centroid1(2,1))/(centroid2(1,1)-centroid1(1,1));
c       = centroid2(2,1)-slope*centroid2(1,1);% b is obtained by substituting the value of slope in the equation(y=mx+c) for any of the centroid point
w0      = [-1*slope; 1];    %ax+by=c=> b=1
b0      = -1*c;

%Plot the initial parameters(curve/hyperplane)

x       = minVal*1.5:0.1:maxVal*1.5;
y       = slope*x+c;
h0      = plot(x,y);

%----------------------Perceptron parameter Calculation-------------------------------------

w   = w0;
b   = b0;
for itr=1:1:1000
    % u=zeros(2*N,1);
    u                   = pointswithLabel(:,1:2)*w+b;
    labelEstimated      = 1./(1+exp(-1*u));
%   labelEstimated=labelEstimated';
    error               = label-labelEstimated;
    MSE                 = (1/(2*N))*sum(error.*error);


    gradwrtoB           = -1*(2/(2*N))*sum(error.*labelEstimated.*(1-labelEstimated));
    gradwrtW1           = -1*(2/(2*N))*sum(error.*labelEstimated.*(1-labelEstimated).*pointswithLabel(:,1));
    gradwrtW2           = -1*(2/(2*N))*sum(error.*labelEstimated.*(1-labelEstimated).*pointswithLabel(:,2));
    gradW               = [gradwrtW1;gradwrtW2];
    
    theta               = 0.5;
    newW                = w-2*theta.*gradW;
    newB                = b-2*theta.*gradwrtoB;
    
    diff                = [newW - w; newB-b];
    if max([max(abs(diff(1:2,1))),abs(diff(3,1))])<=0.002
        break;
    end

    w           = newW;
    b           = newB;
    slope       = -1*w(2,1)/(w(1,1));
    c           = -1*b/(w(1,1));
    
    y   = slope*x+c;
    h   = plot(x,y,'g');
    
    pause(2);
    delete(h);
end

slope   = -1*w(2,1)/(w(1,1));
c       = -1*b/(w(1,1));
y       = slope*x + c;
h       = plot(x,y,'g');

    
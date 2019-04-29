function [ dataPointsWithLabel ] = dataGeneration( centroid,Radius,N )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%INPUT:
%   centroid-an array holding the coordinates for the centroid of each of
%   the  dt cluster
%   Radius-Array of inner and outer radius of each of the data cluster
%   points.
%   N-Array containing no of points of each cluster
%   centroid-origin point of the ring
%OUTPUT:
%   datapoints-holds the [x;y] coordinates of the random points generated
%Example:
%   
%--------------------------------------------------------------------------
%Developed by:Mathew Francis
%Revision History:
%   Initial Draft:14/09/2014
%--------------------------------------------------------------------------
   
    s=size(centroid);
    noOfClusters=s(2);
    dataPoints=zeros(2,sum(N));
    label=zeros(1,sum(N));
    j=1;
    for i=1:1:noOfClusters
        [ points ] = genrandomPoints( Radius(1,i),Radius(2,i),N(i),centroid(:,i)  );
        dataPoints(:,j:sum(N(1:i)))= points;
        j=sum(N(1:i))+1;
    end
    
    j=1;
    for i=1:1:noOfClusters
        label(1,j:sum(N(1:i)))=i;
        j=sum(N(1:i))+1;
    end
    dataPointsWithLabel=[dataPoints;label];
    figure;
    hold on;
    j=1;
    for i=1:1:noOfClusters
        scatter(dataPoints(1,j:sum(N(1:i))),dataPoints(2,j:sum(N(1:i))),'filled');
        j=sum(N(1:i))+1;
    end
    title('Original Data');
%     legendString=[];
%     for i=1:1:noOfClusters
% %            legendString=[legendString (int2str(i))];
%         legend((int2str(i)));
%     end       
    
end


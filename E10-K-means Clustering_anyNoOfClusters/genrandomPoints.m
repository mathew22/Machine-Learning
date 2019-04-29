function [ points ] = genrandomPoints( r1,r2,N,centroid  )
%genrandomPoints function generates N points with centre as centroid. the points will lie inside a ring of radius r2-r1. 
%   
%INPUT:
%   r1-inner radius of the ring
%   r2-outer radius of the ring
%   N-no of points to be generated
%   centroid-origin point of the ring
%OUTPUT:
%   points-holds the [x;y] coordinates of the random points generated
%Example:
%   points=genrandomPoints( 5,15,1000,[10;10] 
%--------------------------------------------------------------------------
%Developed by:Mathew Francis
%Revision History:
%   Initial Draft:9/09/2014
%--------------------------------------------------------------------------
    if(r2>=r1)  %If both the values are equal it will create points on the radius
        randAngles=rand(1,N)*2*pi;  %Generate random angle values between o and 2*pi
        points=zeros(length(centroid),N);
    %     radius=r2-r1;               %radius of the ring.
        for i=1:1:N
    %         r=radius*rand(1);       %Scaling the radius by a factor between( 0 to1) so that the point will lie inside the radius not on the boundary
    %         eCap=[cos(randAngles(i));sin(randAngles(i))];   %Random direction
    %         points(:,i)=centroid+[r1;r1].*eCap+r*eCap;  %First term-centroid 
    %         
    %        Or
           alpha=rand(1);
           eCap=[cos(randAngles(i));sin(randAngles(i))];
           maxLimit=r2*eCap;    %Since the points are angular the radius need to be multiplied by cos and sine of angle. 
           minLimit=r1*eCap;
           points(:,i)=centroid+alpha*minLimit+(1-alpha)*maxLimit;    %This line is a simplification of the above line.
        end
  
%          scatter(points(1,:),points(2,:));
%          hold on;
    else 
        error('Outer radius should be less than inner radius');
    end
end


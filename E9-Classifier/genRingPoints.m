function [ ringPoints ] = genRingPoints( r2,r3,centroid,N )
%Generates N number of points with the given centroid and within a ring of
%radius r2 and r3
%   Detailed explanation goes here
    ringPoints=zeros(length(centroid),N);
%     oneV=ones(length(centroid),1);
%     randDir=rand(length(centroid),N);
    angle=0:2*pi/N:(2*pi-(2*pi/N));
    directions=[cos(angle);sin(angle)];
    for i=1:1:N
        r=rand(1);
%         randDirX=rand(1);        %Generating arbitrary direction
%         randDirY=rand(1); 
%         randDir=[randDirX;randDirY];

%         normValue=norm(randDir(:,i));
%         randDir(:,i)=randDir(:,i)/normValue;        %Making amplitude=1 to indicate direction only
%         points(:,i)=centroid+r*(oneV-2*randDir(:,i));       %One minus two times is done to get positive and -ve points
        ringPoints(:,i)=centroid+r*r2* directions(:,i)+(1-r)*r3*directions(:,i); 
    end
    

end


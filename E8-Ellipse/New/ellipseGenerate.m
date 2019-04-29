function [  ] = ellipseGenerate( angleFactor,N,sigmaX,sigmaY )
%Generates a set of uniform points around the origin.Later on multipled by
%a matrix sigma to make it elongated in one direction.Finally it is rotated
%to the specified angle using the rotation matrix R
%Input Variables
%      angleFactor->multiplication factor with pi(180) which defines the angle of rotation)  
%      sigmaX->Required std deviation in tje x direction
%      N->no of points used for  generating the ellipse
%Eg:-ellipseGenerate( 0.333,600,4,1 )
   
    uniformPoints=genrandomPoints( 0,10,N,[0;0] );
    scatter(uniformPoints(1,:),uniformPoints(2,:),15,'b');
    sigma=[sigmaX 0; 0 sigmaY];
    uncorrelatedPoints=sigma*uniformPoints;

    hold on;
    scatter(uncorrelatedPoints(1,:),uncorrelatedPoints(2,:),15,'r');

    maxX=max(abs(max(uncorrelatedPoints(1,:))),abs(min(uncorrelatedPoints(1,:))));
    maxY=max(abs(max(uncorrelatedPoints(1,:))),abs(min(uncorrelatedPoints(1,:))));
    m=max(maxX,maxY);
    axis([ -1.2*m 1.2*m -1.2*m 1.2*m ]);
    angle=pi*angleFactor;
    R=[ cos(angle) -1*sin(angle);sin(angle) cos(angle)];
    rotatedPoints=R*uncorrelatedPoints;
    scatter(rotatedPoints(1,:),rotatedPoints(2,:),15,'k');

%     axis([ -80 80 -80 80 ]);
    legend('Uniform Data','Independent Data','Rotated Points');
    title(['Ellipse-Rotated by angle' ' ' int2str(180*angleFactor)]);
end


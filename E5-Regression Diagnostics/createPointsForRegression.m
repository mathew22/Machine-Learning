function [ x2,y2 ] = createPointsForRegression( m,c,xmin,xmax,mu,sigma,N)
%This function creates a set of points for a line(y=mx+c+noise) based on the input values given and adds a gaussian noise to it. 
%   Eg:-[ x1,y1 ] = createPointsForRegression( 1,1,1,10,0,1,9)
     step_size=(xmax-xmin)/(N-1);        %step size along the x axis for creating the N points.N-1 is used so as to avoid the additional point coming when N is used
    x=xmin:step_size:xmax;              %Range of values for x
    %l=length(x);
    y=m*x+c;                            %Range of values for y
    %scatter(x,y)
    %y=y+normrnd
    %plot(x,y);
    
    random_number=normrnd(mu,sigma,1,N);
    vMin=[min(x);min(y)];
    vMax=[max(x);max(y)];
    noOfPoints=ceil(N/2.2);
    randPop = generatePopulation( vMin,vMax,noOfPoints );
    
    %x1=x+random_number(1,:);
    y1=y+random_number(1,:)+rand(1,N);
    %figure;scatter(x,y)
    
    x2=[x,randPop(1,:)];
    y2tmp=[y1,randPop(2,:)];
    
    [x2,Index] = sort(x2,'ascend');
     y2=zeros(1,length(x2));
     for i=1:1:length(x2)
            y2(i)=y2tmp(Index(i));
     end
    plot(x,y);
    xlabel('x-axis')
    ylabel('y-axis')
%     hold on;
%     scatter(x2,y2)
%     xlabel('x-axis')
%     ylabel('y-axis')
%     hold  on;


end


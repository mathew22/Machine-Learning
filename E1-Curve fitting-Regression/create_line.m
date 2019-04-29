function [ x1,y1] = create_line( m,c,xmin,xmax,mu,sigma,N)
%This function creates a set of points for a line(y=mx+c+noise) based on the input values given and adds a gaussian noise to it. 
%    
    step_size=(xmax-xmin)/(N-1);        %step size along the x axis for creating the N points.N-1 is used so as to avoid the additional point coming when N is used
    x=xmin:step_size:xmax;              %Range of values for x
    %l=length(x);
    y=m*x+c;                            %Range of values for y
    %scatter(x,y)
    %y=y+normrnd
    %plot(x,y);
    
    random_number=normrnd(mu,sigma,1,N);
    
    %x1=x+random_number(1,:);
    x1=x;
    y1=y+random_number(1,:);
    %figure;scatter(x,y)
    plot(x,y)
    hold on;
    scatter(x1,y1)
    xlabel('x-axis')
    ylabel('y-axis')
    hold  on;
end


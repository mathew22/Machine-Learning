function [ kernelDensityEstimate ] = kernelDensityEstimate( h )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%     kernelDensityEstimate( 1 )
    x1= 0 + 1.*randn(100,1); %set of 100 points with mean o and std dev=1
    x2= 3 + 1.*randn(100,1);
    x1=x1';
    x2=x2';
    x=[x1 x2]; %This is a bimodal distribution.
    
    xMin=min(x);
    xMax=max(x);
    l1=length(x);
    xVal=(2*xMin):0.1:(2*xMax);
    l2=length(xVal);
   
    kernelDensityEstimate=zeros(1,l2);
    for i=1:1:l2
        for j=1:1:l1
            kernelDensityEstimate(i)=kernelDensityEstimate(i)+exp(-1*((xVal(i)-x(j))^2)/(2*h*h));
        end
    end
    
    kernelDensityEstimate=kernelDensityEstimate/l1;  %normalizing
%     figure;
    subplot(1,2,1);ksdensity(x);
    title('Matlab inbult function');
    subplot(1,2,2);plot(xVal,kernelDensityEstimate);
    title('My Custom Function');
    
end


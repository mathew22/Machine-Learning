function [ yVal ] = evalY( xVal,a,b,mu,sigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    yVal=a*xVal+repmat(b,1,length(xVal));
    random_number=normrnd(mu,sigma,1,length(xVal));
    yVal=yVal+random_number;
end


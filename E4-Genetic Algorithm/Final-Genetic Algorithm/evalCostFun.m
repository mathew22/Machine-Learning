function [ cost ] = evalCostFun( X )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    costFun=@(V)sum(V.^2);
    
    cost=costFun(X);
end


function [ xMVal yMVal ] = selectMPoints( x,y,noOfModelParam )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    selMPointIndex=randperm(length(x),noOfModelParam);
    selMPointIndex=sort(selMPointIndex,'ascend');
    l=length(selMPointIndex);
    xMVal=zeros(1,noOfModelParam);
    yMVal=zeros(1,noOfModelParam);
    for i=1:1:l
        xMVal(i)=x(selMPointIndex(i));
        yMVal(i)=y(selMPointIndex(i));
    end
    

end


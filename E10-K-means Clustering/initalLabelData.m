function [ dataWithLabel,glabel ] = initalLabelData( data,noOfGroups )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    s=size(data);
    dataLabel=zeros(1,s(2));
    glabel=1:1:noOfGroups;
    j=1;
    for i=1:1:s(2)
        dataLabel(i)=glabel(j);
        if j==noOfGroups
            j=0;
        end
        j=j+1;
    end
    dataWithLabel=[data;dataLabel];
    
    
    
    
end


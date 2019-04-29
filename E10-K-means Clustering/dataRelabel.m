function [ dataWithLabel ] = dataRelabel( data,meanOfGroup,glabel,distanceMeasure )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    s=size(data);
    s1=size(meanOfGroup);
    newLabel=zeros(1,s(2));
    eucDist=zeros(1,s1(2));
    for i=1:1:s(2);
        for j=1:1:s1(2)
            points=[data(:,i)';meanOfGroup(:,j)'];
            eucDist(j)=pdist(points,distanceMeasure);
        end
       m=min(eucDist);
       newLabel(i)=glabel(eucDist==m);
       
    end
    
     dataWithLabel=[ data;  newLabel];
end


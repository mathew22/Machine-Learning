function [ groupedData,meanOfGroup ] = groupDataAndMean( dataWithLabel,glabel,prevMean )
%UNTITLED2 Summary of , this function goes here
%   Detailed explanation goes here

    
    dataLabel=dataWithLabel(3,:);
    groupedData=cell(1,length(glabel));
    meanOfGroup=zeros(2,length(glabel));
    for i=1:1:length(glabel)
%         
        groupedData{1,i}=dataWithLabel(1:2,dataLabel==glabel(i));
        if isempty(groupedData{1,i});
            meanOfGroup(:,i)=prevMean(:,i);
        else
            meanOfGroup(:,i)=mean(groupedData{1,i},2);
%         h(i)=scatter(tmp(1,:),tmp(2,:));
        end
    
    end

end


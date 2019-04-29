function [h  ] = plotLabeledData( groupedData,glabel,color )
%UNTITLED2 Summary of , this function goes here
%   Detailed explanation goes here
    
     
    
    h=zeros(1,length(glabel));
    for i=1:1:length(glabel)
        
        t= color(i,:);
         
         %h(i)=scatter(groupedData{1,i}(1,:),groupedData{1,i}(2,:),color(i));
          h(i)=scatter(groupedData{1,i}(1,:),groupedData{1,i}(2,:),'o','markerfacecolor',t);
    
    end

end


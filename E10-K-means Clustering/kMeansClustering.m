function [  ] = kMeansClustering( k )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    close all;
    centroid=[0 0;0 10;-10 0; 10 10; -10 -10];
    centroid=centroid';
    Radius=[0 0 0 0 0;4 4 4 4 4];
    N=[50 50 50 50 50];
    maxItr=1000;

    noOfGroups=k;
    [ dataPointsWithLabel ]= dataGeneration( centroid,Radius,N );
    permuteOrder=randperm(sum(N),sum(N));
    for i=1:1:sum(N);
        dataPointsWithLabel1(:,i)=dataPointsWithLabel(:,permuteOrder(i));
    end
    dataPointsWithLabel=dataPointsWithLabel1;
%     dataPointsWithLabel(:,i)=permute(dataPointsWithLabel,permuteOrder);
    [ dataWithLabel,glabel ] = initalLabelData( dataPointsWithLabel(1:2,:),noOfGroups );
    figure;
    hold on;
    color='ymcrgbmymc';
    prevMean=zeros(2,length(glabel));
    maxVariation=10;
    for i=1:1:maxItr
    % while maxVariation>0
        [ groupedData,meanOfGroup ] = groupDataAndMean( dataWithLabel,glabel ,prevMean);
        diffOfMean=prevMean-meanOfGroup;
        eucDist=sum(diffOfMean.*diffOfMean);
        maxVariation=max(sqrt(eucDist));
        if maxVariation<=0.00000001
            break;
        end
        prevMean=meanOfGroup;
        
       [h  ] = plotLabeledData( groupedData,glabel,color );
        m=scatter(meanOfGroup(1,:),meanOfGroup(2,:),'d','k','filled');
        pause(3);
        delete(h);
        delete(m);
        [ dataWithLabel ] = dataRelabel( dataPointsWithLabel(1:2,:),meanOfGroup,glabel,'euclidean' );
%         diffOfMean=prevMean-meanOfGroup;
%         eucDist=sum(diffOfMean.*diffOfMean);
%         maxVariation=max(sqrt(eucDist));
%         if maxVariation<=0.00000001
%             break;
%         end
%         prevMean=meanOfGroup;
    end
      plotLabeledData( groupedData,glabel ,color );
       m=scatter(meanOfGroup(1,:),meanOfGroup(2,:),'d','k','filled');
       title('K-means Clustered Data');


end


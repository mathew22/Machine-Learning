function [  ] = geneticAlgorithm( sMin,sMax,muX,muY,sigmaX,sigmaY,noOfPoints,maxItr )
%THis program implements the genetic algoritm for optimization
%  Eg:-geneticAlgorithm([-100;-100],[100;100],-5,5,1,1,25,20)

%     xMin=muX-3*sigmaX;
%     xMax=muX+3*sigmaX;
%     
%     yMin=muY-3*sigmaY;
%     yMax=muY+3*sigmaY;
    
%     sMin=[xMin;yMin];       %mimimum vector of th search space
%     sMax=[xMax;yMax];       %maximum vector of the search space
    
%     sMin=int64(sMin*100);
%     sMax=int64(sMax*100);
    m=max(sMax);
    tmp=toBinary( round(m),1 ); %to get t he no of bits for the binary representation. length passedin the function is 1 but it will return the correct no of bits required.
    l=length(tmp);          %Find the number of bits required for the binary representation
    

    mu=[muX;muY];
    sigma=[sigmaX 0;0 sigmaY];
    initPop= generatePopulation( sMin,sMax,noOfPoints);
    track=zeros(2,maxItr);
    
    population=initPop;
    for i=1:1:2
        for j=1:1:noOfPoints
             population(i,j)=sign(population(i,j))*((sign(population(i,j))*population(i,j))-sign(population(i,j))*rem(population(i,j),1));
        end
    end
%     cost=zeros(1,noOfPoints);
    popBinaryX=zeros(noOfPoints,l);   %Additional bit positin is for the sign bit to indicate positive and negative no's
    popBinaryY=zeros(noOfPoints,l);
    
    contourPlot( sMin,sMax,muX,muY,sigmaX,sigmaY,noOfPoints );
    title('Genetic Algorithm');
    hold on;
    h=scatter(population(1,:),population(2,:));
    pause(2);
    
    for itr=1:1:maxItr
         cost= evalCost( population,mu,sigma );
        for popNo=1:1:noOfPoints
            popBinaryX(popNo,:)= toBinary(  population(1,popNo),l-1 );
            popBinaryY(popNo,:)= toBinary(  population(2,popNo),l-1 );
            
        end
        
        i=1;
        newPop=zeros(2,noOfPoints);
        noOfCrossover=round(.95*noOfPoints);
        if rem(noOfCrossover,2)~=0; %we need even no of points even as crossover is done on a pair of points
            noOfCrossover=noOfCrossover-1;
        end
        while i<=(noOfCrossover)
            selIndex1=0;    %indexes which are not to be considered for crossover This will be zero initially and will have non zero values then
            selIndex2=0;
            [ selectedPointIndex1,selctedPoint1,Index1,Index2 ] = selectSample( population,selIndex1,selIndex2);
            [ selectedPointIndex2,selctedPoint2,selNIndex1,selNIndex2 ] = selectSample( population,Index1,Index2);
            [ crossX1,crossX2] = doCrossover( popBinaryX(selectedPointIndex1,:),popBinaryX(selectedPointIndex2,:) );
            [ crossY1,crossY2] = doCrossover( popBinaryY(selectedPointIndex1,:),popBinaryY(selectedPointIndex2,:) );
            [ newSample1] = [ crossX1;crossY1];
            [ newSample1 ] = boundCheck(newSample1, sMin,sMax );
            [ newSample2] = [ crossX2;crossY2];
            [ newSample2 ] = boundCheck(newSample2, sMin,sMax );
            %             if crossX1<xMin*100
%                 crossX1=xMin*100;
%             elseif crossX2<xMin*100
%                 crossX2=xMin*100;
%             elseif crossX1>xMax*100
%                 crossX1=xMax*100;
%             elseif crossX2>xMax*100
%                 crossX2=xMax*100;
%             end
            
            

            %             if crossY1<yMin*100
%                 crossY1=yMin*100;
%             elseif crossY2<yMin*100
%                 crossY2=yMin*100;
%             elseif crossY1>yMax*100
%                 crossY1=yMax*100;
%             elseif crossY2>yMax*100
%                 crossY2=yMax*100;
%             end
            newPop(:,i)=newSample1;
            newPop(:,i+1)=newSample2;
            i=i+2;
        end
        
         while i<=(noOfPoints)
            selIndex1=0;
            selIndex2=0;
            [ selectedPointIndex1,selctedPoint1,selIndex1,selIndex2 ] = selectSample( population,selIndex1,selIndex2);
            %[ selectedPointIndex2,selctedPoint2,selIndex1,selIndex2 ] = selectSample( selIndex1,selIndex2);
            [ mutX] = doMutation( popBinaryX(selectedPointIndex1,:));
            [ mutY] = doMutation( popBinaryY(selectedPointIndex1,:));
            newSample=[mutX;mutY];
            [ newSample ] = boundCheck(newSample, sMin,sMax );
            %             if  mutX<xMin*100
%                  mutX=xMin*100;
%             elseif mutY<yMin*100
%                 mutY=yMin*100;
%             elseif  mutX>xMax*100
%                  mutX=xMax*100;
%             elseif mutY>yMax*100
%                 mutY=yMax*100;
%             end

            newPop(:,i)=newSample;
            %newPop(:,i)=[crossX2;crossY2];
            i=i+1;
         end
        
%          for popNo=1:1:N
            newCost = evalCost( newPop,mu,sigma );
    %         popBinaryX(popNo,:)= toBinary(  newPop(1,popNo),l );
    %         popBinaryY(popNo,:)= toBinary(  newPop(2,popNo),l );
%         end
        combinedCost=[cost,newCost];
        %combinedCostFun=sort(combinedCostFun,'desc');
%         totalPopulation=zeros(2,N);
        totalPopulation=[population,newPop];


        [combinedCost,Index] = sort(combinedCost,'descend');
        
        for i=1:1:noOfPoints
            population(:,i)=totalPopulation(:,Index(i));
        end
        track(:,itr)=population(:,1);           %store the best point in each iteration
        
        delete(h);
        h=scatter(population(1,:),population(2,:));
        pause(2);
    end
    
%     h=scatter(track(1,:),track(2,:));
    delete(h);
    h=plot(track(1,:),track(2,:),'red');
    pause(2);
    delete(h);
    scatter(track(1,maxItr),track(1,maxItr));       %scatter plot of the best point
    text(track(1,maxItr),track(2,maxItr),['(' num2str(track(1,maxItr)) ',' num2str(track(2,maxItr)) ')'])%Display the co-ordinates of the point in the graph
end


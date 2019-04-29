function [] = sphericalClustering( noOfPoints , noOfClusters ,maxItr)
%sphericalClustering( 200 , 4,5)
% no of colors mentioned =5 . So clusters cannot be grater than 5
% Represents the vectors using pointed arrows ( use quiver function )

close all;


k = noOfClusters;
noOfVectors = noOfPoints;

% vectors and their corresponding labels
vectors = zeros( 2, noOfVectors );
label = zeros( 1, noOfVectors );


sumX =0.0;
sumY =0.0;

% Unit Vectors in random directions
for i=1:1:noOfVectors
    randomAngle = rand(1) *2*pi;
    vectors(1,i) = cos( randomAngle);
    vectors(2,i) = sin( randomAngle);
%     sumX = sumX + vectors(1,i);
%     sumY = sumY + vectors( 2, i );
    
end

% Computing the mean
% meanX = sumX / noOfVectors;
% meanY = sumY / noOfVectors;
    

% Subtract mean from the set of points
% for i=1:1:noOfVectors
%    vectors(1,i) = vectors(1,i) - sumX;
%    vectors(2,i) = vectors(2,i) - sumY;
%  
% end

% Makeall the vecto


figure; 
classLabel = 1;
% initialize the labels
for i =1:1: noOfVectors
    label(1,i)= classLabel;
    classLabel = classLabel + 1;
    if classLabel == k+1
        classLabel =1;
    end
end
colors =[ 'm', 'b' ,'g','k','y'];

% Array to hold the mean values from the previous itertion
meanVectorsPrevItr = zeros( 2,k);

 % Plot the vectors for iteration 0
    for i=1:1:noOfVectors
        x=[0, vectors(1,i)];
        y = [0 , vectors(2,i)];
        quiver( 0 , 0 ,vectors(1,i) ,vectors(2,i), 'b') ;
      
        hold on;
        %pause(0.02);
    end
    
     xlim([-1 1]);
     ylim([ -1 1]);
     hold all;
     %delete(p);
     
     pause( 5);
%Itr Start
for itr =1:1:maxItr   
    
    % Plot the vectors
    for i=1:1:noOfVectors
        x=[0, vectors(1,i)];
        y = [0 , vectors(2,i)];
        quiver( 0 , 0 ,vectors(1,i) ,vectors(2,i), colors(label(i)) );
      
        hold on;
        pause(0.02);
    end
    
    if itr ~=1 
        delete( p);
        pause(2);
    end;
    

    meanVectors = zeros(2,k);
    noOfVectorsInEachClass = zeros(1, k);
    % Computing the sum of vectors of each class as well as  number of
    % points  belonging to each class
    for i=1:1:noOfVectors
        ClassIndex = mod(label( i) ,k+1);
       meanVectors(:,ClassIndex) =  meanVectors(:,ClassIndex) + vectors(:,i);
       noOfVectorsInEachClass(1,ClassIndex ) = noOfVectorsInEachClass(1, ClassIndex ) +1;
    end
    
    % average and normalize
    for i =1:1:k
        meanVectors(:,i) = meanVectors(:,i) /noOfVectorsInEachClass(1, i);
        mag = sum(meanVectors(:,i) .* meanVectors(:,i) );
        meanVectors(:,i) = meanVectors(:,i)/sqrt(mag);
    end
    
    % Difference in previous mean and current mean
    diff = meanVectors - meanVectorsPrevItr;
    
    % sum of teh difference in each dimensio
    sumX= sum( abs( diff(1,:)));
    sumY= sum( abs( diff(2,:)));
    % exit if convergence
    if sumX == 0.00 && sumY == 0.00
        break
    end
    
    % update the previous mean vectors
    meanVectorsPrevItr = meanVectors;
    
    % Plot the mean Values in black color
    for i=1:1:k
        x=[0, meanVectors(1,i)];
        y = [0 , meanVectors(2,i)];
        p(i) = quiver( 0,0 , meanVectors(1,i), meanVectors(2,i),'r' ,'LineWidth',3);
        hold on;
        pause(1);
    end
    
     plottitle= sprintf('Iteration-%d ', itr);
   plot( [0 ,0], [ 0,0]);
    title( plottitle);



    % update the label wrto the closest mean
    for i =1:1: noOfVectors
        dotProductArray = zeros( 1, k);
        for j =1:1:k
            dotProductArray(1,j) = sum( vectors(:,i).* meanVectors(:,j));
        end
        maxDotProduct = max( dotProductArray);
        label(1,i ) =find( dotProductArray(:)== maxDotProduct);

    end
    
   
    
    
    
end
% Plot the final mean Vectors
 for i=1:1:k
        x=[0, meanVectors(1,i)];
        y = [0 , meanVectors(2,i)];
        p(i) = quiver(0,0, meanVectors(1,i), meanVectors(2,i) , 'r','LineWidth',3 );
        hold on;
        pause(1);
 end
    title('Spherical Clustering');







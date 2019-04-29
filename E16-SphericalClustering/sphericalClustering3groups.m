function [] = sphericalClustering3groups( noOfPoints , noOfClusters ,maxItr)
%sphericalClustering( 200 , 4,5)
% no of colors mentioned =5 . So clusters cannot be grater than 5
% Represents the vectors using pointed arrows ( use quiver function )

close all;

% Data Generation

% Define 3 unit vectors at anangle 0 , 90 and 270 
% generate some vectors around these points in an interval -30 to + 30

% no of fixed vectors around which other random vectors are generated
 noOfFixedVectors = 3;
 totalVectors = 10;
 k = 3;
 maxItr =10;
 
 %  Matrix to storeth efixed vectors
 unitVectors = zeros( 2, totalVectors);
 labelArray = zeros( 1, totalVectors);
 
 theta = 0;
 % Generate vectors at 0 , 0 , 180 degrees
%  for i =1:1:noOfFixedVectors
%      unitVectors(:, i )   = [cos( theta ) ; sin( theta)];
%      
%      theta = theta + (pi/2);
%  end
  % Generate vectors at 0 , 0 , 180 degrees
 unitVectors(:,1) = [1;0];
 unitVectors(:,2) = [0;1];
 unitVectors(:,3) = [-1 ; 0 ];
  unitVectors(:,4) = [0.9585;-0.2850];
 unitVectors(:,5) = [0.9846 ; 0.1749 ];
  unitVectors(:,6) = [0.1622;0.9868];
 unitVectors(:,7) = [-0.2896 ; 0.9572 ];
  unitVectors(:,8) = [-0.9832;-0.1826];
 unitVectors(:,9) = [-0.8695 ; 0.4939 ];
 unitVectors(:,10) = [-0.9943 ; 0.1068 ];
 
 save('vectors.txt','unitVectors');
 
 % Range of angle values
 angleMin = -30*(pi/180);
 angleMax = 30 *( pi/180);

 
 % generate random unit vectors
%  for i =4:1:6
%      randomAngle = angleMin + rand(1) *( angleMax -angleMin );
%      unitVectors(:,i) = [ cos( randomAngle) ; sin( randomAngle)];
%  end
 
 
 % generate random unit vectors
%  for i =6:1:7
%      randomAngle = angleMin + rand(1) *( angleMax -angleMin )+ (pi/2);
%      unitVectors(:,i) = [ cos( randomAngle) ; sin( randomAngle)];
%  end
 
 % generate random unit vectors
%   for i =8:1:10
%      randomAngle = angleMin + rand(1) *( angleMax -angleMin )+ (pi);
%      unitVectors(:,i) = [ cos( randomAngle) ; sin( randomAngle)];
%   end
 
 % dummyplot
 figure;
 pl = plot( [ 0,0], [ 0, 0]);
 xlim([-1 1]);
 ylim([ -1 1]);
 delete( pl );
 hold on;
 
 colors =[ 'm', 'b' ,'g','c','y'];
 
  % plot the initial population
for i =1:1: size( unitVectors,2)
    quiver(0 , 0 , unitVectors(1,i) , unitVectors(2,i),'k' );
    hold on;
    pause( 2);
end


classLabel =1;
% initialize the label array
for i =1:1:totalVectors
    labelArray(1, i ) = classLabel;
    classLabel = classLabel+1;
    if classLabel == k+1
        classLabel =1;
    end
end



meanVectorArray = zeros( 2, k);
noOfVectorsInEachClass = zeros( 1, k);
prevItrMeanVectorArray = zeros( 2,k);
prevItrLabelArray = zeros( 1, totalVectors );


fp = fopen('vectors.txt','w');




for itr =1:1:maxItr
    meanVectorArray = zeros( 2, k);
    % Plotting the points with color coding wrto the class labels
    for i =1:1: size( unitVectors,2)
        quiver(0 , 0 , unitVectors(1,i) , unitVectors(2,i),colors( 1, labelArray(1,i)) );
        hold on;
        pause( 2);
        meanVectorArray(:, labelArray(1,i)) =  meanVectorArray(:, labelArray(1,i)) + unitVectors(:,i);
        noOfVectorsInEachClass(1,labelArray(1,i)) = noOfVectorsInEachClass(1,labelArray(1,i)) +1;
    end
    
    if( itr ~=1)
        delete( p1);
    end
    % Averaging and normalizing the mean vectors
    for j=1:1:k
        meanVectorArray(:,j) = meanVectorArray(:,j)  / noOfVectorsInEachClass(1,j);
        mag = norm( meanVectorArray(:,j));
        meanVectorArray(:,j) = meanVectorArray(:,j)/ mag;
    end
    %Writing tofile
    fprintf( fp,'itr- %d\n', itr );
    fprintf( fp,'Label Values\n' );
    for i =1:1: totalVectors
        fprintf( fp, '%d ',labelArray(1,i));
    end
    fprintf( fp, '\n');
    fprintf( fp,'mean Values\n' );
    for j =1:1: k
        fprintf( fp, '%f %f \n',meanVectorArray(1,j), meanVectorArray(2,j));
    end
    fprintf( fp, '****************\n');
    
    % check for convergence
    diff = prevItrLabelArray - labelArray;
    
    if ( sum ( sum( diff)) == 0 )
        break;
    end
    % updating the previous iteration array
    prevItrLabelArray = labelArray;
    
    % Plotting the mean vectors
    %Plot the mean Values in black color
    for i=1:1:k
        p1(i) = quiver( 0,0 , meanVectorArray(1,i), meanVectorArray(2,i),colors(1,i) ,'LineWidth',3);
        hold on;
        pause(1);
    end
    
    plottitle= sprintf('Iteration-%d ', itr);
    title( plottitle);
    
    % updating the class label
     for i =1:1: totalVectors
        dotProductArray = zeros( 1, k);
        for j =1:1:k
            dotProductArray(1,j) = sum( unitVectors(:,i).* meanVectorArray(:,j));
        end
        maxDotProduct = max( dotProductArray);
        labelArray(1,i ) =find( dotProductArray(:)== maxDotProduct);

    end
    
    
    
end
 %Plot the mean Values in black color
    for i=1:1:k
        p1(i) = quiver( 0,0 , meanVectorArray(1,i), meanVectorArray(2,i),colors(1,i) ,'LineWidth',3);
        hold on;
        pause(1);
    end
    fclose(fp);
    title('SphericalClustering');
    
    
    



% 
% 
% 
% 
% k = noOfClusters;
% noOfVectors = noOfPoints;
% 
% % vectors and their corresponding labels
% vectors = zeros( 2, noOfVectors );
% label = zeros( 1, noOfVectors );
% 
% 
% sumX =0.0;
% sumY =0.0;
% 
% % Unit Vectors in random directions
% for i=1:1:noOfVectors
%     randomAngle = rand(1) *2*pi;
%     vectors(1,i) = cos( randomAngle);
%     vectors(2,i) = sin( randomAngle);
% %     sumX = sumX + vectors(1,i);
% %     sumY = sumY + vectors( 2, i );
%     
% end
% 
% % Computing the mean
% % meanX = sumX / noOfVectors;
% % meanY = sumY / noOfVectors;
%     
% 
% % Subtract mean from the set of points
% % for i=1:1:noOfVectors
% %    vectors(1,i) = vectors(1,i) - sumX;
% %    vectors(2,i) = vectors(2,i) - sumY;
% %  
% % end
% 
% % Makeall the vecto
% 
% 
% figure; 
% classLabel = 1;
% % initialize the labels
% for i =1:1: noOfVectors
%     label(1,i)= classLabel;
%     classLabel = classLabel + 1;
%     if classLabel == k+1
%         classLabel =1;
%     end
% end
% colors =[ 'm', 'b' ,'g','c','y'];
% 
% % Array to hold the mean values from the previous itertion
% meanVectorsPrevItr = zeros( 2,k);
% 
%  % Plot the vectors for iteration 0
%     for i=1:1:noOfVectors
%         x=[0, vectors(1,i)];
%         y = [0 , vectors(2,i)];
%         quiver( 0 , 0 ,vectors(1,i) ,vectors(2,i), 'b') ;
%       
%         hold on;
%         %pause(0.02);
%     end
%     
%      xlim([-1 1]);
%      ylim([ -1 1]);
%      hold all;
%      %delete(p);
%      
%      pause( 5);
% %Itr Start
% for itr =1:1:maxItr   
%     
%     % Plot the vectors
%     for i=1:1:noOfVectors
%         x=[0, vectors(1,i)];
%         y = [0 , vectors(2,i)];
%         quiver( 0 , 0 ,vectors(1,i) ,vectors(2,i), colors(label(i)) );
%       
%         hold on;
%         pause(0.02);
%     end
%     
%     if itr ~=1 
%         delete( p);
%         pause(2);
%     end;
%     
% 
%     meanVectors = zeros(2,k);
%     noOfVectorsInEachClass = zeros(1, k);
%     % Computing the sum of vectors of each class as well as  number of
%     % points  belonging to each class
%     for i=1:1:noOfVectors
%         ClassIndex = mod(label( i) ,k+1);
%        meanVectors(:,ClassIndex) =  meanVectors(:,ClassIndex) + vectors(:,i);
%        noOfVectorsInEachClass(1,ClassIndex ) = noOfVectorsInEachClass(1, ClassIndex ) +1;
%     end
%     
%     % average and normalize
%     for i =1:1:k
%         meanVectors(:,i) = meanVectors(:,i) /noOfVectorsInEachClass(1, i);
%         mag = sum(meanVectors(:,i) .* meanVectors(:,i) );
%         meanVectors(:,i) = meanVectors(:,i)/sqrt(mag);
%     end
%     
%     % Difference in previous mean and current mean
%     diff = meanVectors - meanVectorsPrevItr;
%     
%     % sum of teh difference in each dimensio
%     sumX= sum( abs( diff(1,:)));
%     sumY= sum( abs( diff(2,:)));
%     % exit if convergence
%     if sumX == 0.00 && sumY == 0.00
%         break
%     end
%     
%     % update the previous mean vectors
%     meanVectorsPrevItr = meanVectors;
%     
%     % Plot the mean Values in black color
%     for i=1:1:k
%         x=[0, meanVectors(1,i)];
%         y = [0 , meanVectors(2,i)];
%         p(i) = quiver( 0,0 , meanVectors(1,i), meanVectors(2,i),'r' ,'LineWidth',3);
%         hold on;
%         pause(1);
%     end
%     
%      plottitle= sprintf('Iteration-%d ', itr);
%    plot( [0 ,0], [ 0,0]);
%     title( plottitle);
% 
% 
% 
%     % update the label wrto the closest mean
%     for i =1:1: noOfVectors
%         dotProductArray = zeros( 1, k);
%         for j =1:1:k
%             dotProductArray(1,j) = sum( vectors(:,i).* meanVectors(:,j));
%         end
%         maxDotProduct = max( dotProductArray);
%         label(1,i ) =find( dotProductArray(:)== maxDotProduct);
% 
%     end
%     
%    
%     
%     
%     
% end
% % Plot the final mean Vectors
%  for i=1:1:k
%         x=[0, meanVectors(1,i)];
%         y = [0 , meanVectors(2,i)];
%         p(i) = quiver(0,0, meanVectors(1,i), meanVectors(2,i) , 'r','LineWidth',3 );
%         hold on;
%         pause(1);
%  end
%     title('Spherical Clustering');
% 
% 
% 
% 
% 
% 

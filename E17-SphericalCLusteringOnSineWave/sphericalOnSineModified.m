% Program to do spherical clustering on a waveform after dividing it into
% parts
% windowSize =10, k =3 x =0.0:0.1:9.9 maxItr =10;
% windowsize  = 5, k=5

close all;

k = 3;

maxItr =10;
% Range of x-Values
x =0.0:0.1:9.9;


%  Range of y-Values
%y = sin(x)+0.1*( rand(1,100) -0.5);
y = sin(x);
% plot the sinusoid
figure; plot( x, y );
hold all;


% Dimension of vectors taken from the original signal using windowing
% operation
windowSize = 10;


% Find the no of vectors that can be obtained from the given signal;
noOfVectors = length( x)/windowSize;

% get the y limit of the current axes
ylimit = get( gca,'ylim');

% Draw a vertical line at the starting point
plot( [ 0 , 0], ylimit ,'g' ); 
pause( 1);

% Plot the window at each window point
for i =1:1:noOfVectors
    plot( [ x( i * windowSize) ,  x( i * windowSize)], ylimit,'g'  );
    pause(1);
end




% Array to store all the vectors. Each vector is stored in a column
vectorsArray = zeros( windowSize , noOfVectors );

% Class lwabel associated with each vector
labelArray  = zeros( 1, noOfVectors );

% Vector array the mean vector of each class
meanVectorArray = zeros( windowSize , k );
prevItrMeanVectorArray = zeros( windowSize , k );

% Array which stores te number of vectors that belong to each of the
% clusters
noOfVectorsInEachCluster= zeros( 1, k);

% Store the vector in the array and normalize it
for no = 1:1:noOfVectors
    for dim = 1:1:windowSize
        vectorsArray( dim , no ) = y( (no-1)* windowSize + dim );
           
    end
    sumVal = sum( vectorsArray(:,no) );
    meanValue = sumVal / windowSize;
    
    % subtracting th emean value of a vector from itself
%     for dim = 1:1:windowSize
%         vectorsArray( dim , no ) =  vectorsArray( dim , no ) - meanValue;
%     end
    
    % Finding the l2 norm
     l2norm =norm( vectorsArray(:,no));
     % normalizing into unit vector
     vectorsArray(:,no) = vectorsArray(:,no) /l2norm;
end

classLabel =1;
% initialize random labels to each of the vectors
for i =1:1:noOfVectors
    labelArray( 1,i ) = classLabel;
    classLabel = classLabel +1 ;
    if classLabel == k+1
        classLabel = 1;
    end
end

% Spherical Clustering iterations
for itr = 1:1: maxItr
    
    % computing the mean vectors of each class
    
    for i=1:1:k
        % Finding the class index of each vector
        vectorClassIndx =mod( labelArray( i ) ,(k+1)); %NOTE not required . label can be used directly
        meanVectorArray(:, vectorClassIndx) =  meanVectorArray(:, vectorClassIndx) + vectorsArray(:,i);
        % increment the count of vectors belonging to that class
        noOfVectorsInEachCluster(1, vectorClassIndx ) =  noOfVectorsInEachCluster(1, vectorClassIndx ) +1;
    end
    
    % Averaging to find the exact mean vector and normalizing it make it a
    % unit vector
    for j=1:1:k
        meanVectorArray(:,j) = meanVectorArray(:,j)/ noOfVectorsInEachCluster(1, j );
        mag = norm( meanVectorArray(:,j));
        meanVectorArray(:,j) = meanVectorArray(:,j) /mag;
    end
    
    % Check gfor convergence
    diffVector =meanVectorArray - prevItrMeanVectorArray;
    
    l2Sum = 0.0;
    % sum of l2 norm the differences
    for j =1:1:k
        
        l2Sum = l2Sum + norm( diffVector(:,j));
    end
    
    if l2Sum ==0
        break;
    end
        
    
    
    % update the labels of each vector
    for  i =1:1:noOfVectors
        % dotProductArray 
        dotProdArray = zeros(1, k);
        for j =1:1:k
            dotProdArray(1,j) = sum(vectorsArray( :,i) .* meanVectorArray(:,j));
        end
            maxDotProdValue = max( dotProdArray);
            labelArray(1,i ) =find( dotProdArray(:)== maxDotProdValue);
    end
    
    prevItrMeanVectorArray = meanVectorArray;
        
     
    
    
end


   
    
    colors =[ 'm', 'b' ,'g','c','y'];
    % Plot the mean vectors;
    
    figure;
    for j=1:1:k
        subplot(1,k,j); plot( meanVectorArray(:,j),colors(1,j));
        subplottitle = sprintf('MeanVector%d',j);
        title( subplottitle);
        hold on;
    end
   
    
   % Clustered Waveform ( ie the original waveform splitted in terms of the
   % mean vectors   
%    for i=1:1:noOfVectors
%       label =  labelArray(1,i);
%       x1= x(1,(i -1)* windowSize +1 : (i )* windowSize);
%       y1 = meanVectorArray( :,label)';
%        plot( x1 , y1 ,colors( 1,label));
%        hold on;
%    end
%    title( 'Clustered Waveform');

figure;

for j=1:1:k
        dotProductArray=zeros( 1,noOfVectors);
        dotProductArray = vectorsArray'*meanVectorArray(:,j);
        dotProductArray = dotProductArray';
        subplot(k,1,j); plot( dotProductArray);
        subplottitle = sprintf('Similarity with MeanVector%d',j);
        title( subplottitle);
        hold on;
end






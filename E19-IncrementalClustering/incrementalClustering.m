% Main Code for Visualization of the Incremental Clustering
clear all;
close all;
clc;

% Load the Data Set
X = [ -1 , 27 , 31 , 2 , 59 , 3 , 61 , 34 , 0 , 12 ];
dataNum = length( X );

% Set the Parameters
v_d = 4;
lambda = 3;
alpha = 0.01;

% Initialize the Cluster Matrix
newClusterMatrix = [ X(1) , v_d , 1.0 ]';
prevClusterMatrix = zeros( 3 , 1 );

% define color array
colorArray = 'krmbcgy';

% No of samples used for plotting
sampleNum = 50;


% %Display the first data point
figure; scatter( X( 1 , 1 ) , 0 ,'*','b');
hold on;

% Set the limits for x-axis and y-axis
xlim( [ ( min(X)-10 ) ( max(X)+10 ) ] );
ylim( [-0.5 1.5])

% Remove Y-axis Values
set(gca,'YTickLabel',[]);

% % Display title
titleString = [ 'No of Data Points = ' int2str(1) ];
title( titleString);

% % Display the intial Cluster
p = displayClusters( newClusterMatrix, colorArray, sampleNum);
pause(2);
delete( p );

% Looping Over the Data Set
for dataCount = 2 : dataNum
    
    % Display Data Count
    %dataCount
    %pause
    
    % Copy the Cluster Matrix
    prevColNum = size( prevClusterMatrix , 2 );
    newColNum = size( newClusterMatrix , 2 );
    if newColNum > prevColNum
        
        % Extend the Number of Columns
        prevClusterMatrix( 1:3 , prevColNum + 1 ) = zeros( 3 , 1 );
        
    end
    prevClusterMatrix = newClusterMatrix;
    
    % Display the Clusters 
    p = displayClusters( newClusterMatrix, colorArray, sampleNum);
    pause(2);
    
     
    %Display the data point
    scatter( X( 1 , dataCount ) , 0 ,'*','b');
     
     % Display title
    titleString = [ 'No of DataPoints  = ' int2str( dataCount ) ];
    title( titleString);
    
    % Pause for some time
    pause( 2 );
    hold on;
    
    % Remove the plot 
    delete( p );
      
    % Update the Cluster Matrix
    newClusterMatrix = updateClusterMatrix( prevClusterMatrix , X( 1 , dataCount ) , dataCount , v_d , lambda , alpha );
    
    newClusterMatrix
   
    
end

%Displaying the final set of clusters
p = displayClusters( newClusterMatrix, colorArray, sampleNum);
title('Incremental Clustering');
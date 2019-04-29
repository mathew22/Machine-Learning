% Function for Displaying Clusters
% Inputs :-
%           clusterMatrix : The Cluster Matrix Storing the Cluster Information
%           colorArray : The Color Array for Plotting Cluster Membership Functions
%           NOTE: colorArray is a FIXED Size Array with a PRE-DECIDED
%           MAXIMUM NUMBER of COLORS
%           sampleNum : The Number of Samples for Plotting Each Cluster
% Outputs :-
%           y : Return on Success

function [ p ] = displayClusters( clusterMatrix, colorArray, sampleNum )

% Reading the Number of Clusters
[ r , clusterNum ] = size( clusterMatrix );
if ( r ~= 3 ) || ( clusterNum <= 0 )

  disp( '\n\nError in clusterMatrix Dimensions\n\n' );
  
end

% Set the Range for Plotting the Membership Function Values
[ mean_min , min_indx ] = min( clusterMatrix(1,:) );
var_min_indx = clusterMatrix( 2 , min_indx );
[ mean_max , max_indx ] = max( clusterMatrix(1,:) );
var_max_indx = clusterMatrix( 2 , max_indx );
x_min = mean_min - ( 5* sqrt( var_min_indx ) );
x_max = mean_max + ( 5* sqrt( var_max_indx ) );
y_min = -0.5;
y_max = 1.5;

% Set the Range of the X and Y Axes
% MATHEW: Figure Out This Part



% Looping Over the Clusters
for clusterCount = 1 : clusterNum
    
    % Sample the Cluste Membership Function
    mean_val = clusterMatrix( 1 , clusterCount );
    var_val = clusterMatrix( 2 , clusterCount );
    [ xArray , yArray ] = getDataForClustMemFunc( mean_val , var_val , sampleNum );
    
    % Plot the Membership Function
    % MATHEW: Figure Out the Pre-Decided Color Array
    p(clusterCount ) = plot( xArray , yArray , colorArray( clusterCount ) );
    
    % Hold the Plot for the Next Iteration
    hold on;
    
end
 


end
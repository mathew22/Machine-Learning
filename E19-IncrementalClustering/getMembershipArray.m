% Function for computing Membership Array
% Inputs :-
%	   clusterMatrix : Matrix Storing the Cluster Parameters as Columns
%	   curr_x : The Current Value of x
% Returns :-
%	   memValArray : The Membership Value Array
%	   normDistSqrArray : The Normalised Distance Squared Array
% Invoked As : [ memValArray , normDistSqrArray ] = getMembershipArray( clusterMatrix , curr_x );

function [ memValArray , normDistSqrArray ] = getMembershipArray( clusterMatrix , curr_x )

% Reading the Number of Clusters
[ r , clusterNum ] = size( clusterMatrix );
if ( r ~= 3 ) || ( clusterNum <= 0 )

  disp( '\n\nError in clusterMatrix Dimensions\n\n' );
  
end

% Creating the Arrays
normDistSqrArray = zeros( 1 , clusterNum );
memValArray = zeros( 1 , clusterNum );

% Computing the Normalised Distances
% And the Membership Values
for clusterCount = 1 : clusterNum

  % Read the Mean and Variance Values
  meanVal = clusterMatrix( 1 , clusterCount );
  varVal = clusterMatrix( 2 , clusterCount );
  
  % Compute the Distance and Membership
  normDistSqrArray( 1 , clusterCount ) = ( ( curr_x - meanVal ) * ( curr_x - meanVal ) ) / varVal;
  memValArray( 1 , clusterCount ) = exp( -0.5 * normDistSqrArray( 1 , clusterCount ) );

end

% Function for Preparing Samples along X and Y for a Membership Function of a Cluster
% Inputs :-
%           meanVal : The Mean Value of the Cluster
%           varVal : The Variance Value of the Cluster
%           sampleNum : The Number of Samples
% Outputs :-
%           xArray : The Array of Sample Values along X-Axis
%           yArray : The Array of Sample Values along Y-Axis
% Invoked As : [ xArray , yArray ] = getDataForClustMemFunc( meanVal , varVal , sampleNum );

function [ xArray , yArray ] = getDataForClustMemFunc( meanVal , varVal , sampleNum )

% Get the Range
stdVal = sqrt( varVal );
xMin = meanVal - ( 4 * stdVal );
xMax = meanVal + ( 4 * stdVal );
xDiv = ( xMax - xMin ) / ( sampleNum - 1 );
xArray = [ xMin : xDiv : xMax ];
yArray = zeros( 1 , length( xArray ) );

% Compute the Membership Values
distArray = xArray - meanVal;
distArray = ( distArray .* distArray ) / varVal;
yArray = exp( -0.5 * distArray );
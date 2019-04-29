% Function for Updating Mean and Variance Values of Clusters
% Inputs :-
%	   prev_mean : The Previous Mean Value
%	   prev_var : The Previous Variance Value
%	   updateFactor : The Update Factor
%	   curr_x : The Current Value of x
%	   v_d : The Minimum and Default Variance
% Outputs :-
%	   new_mean : The Updated Value of Mean
%	   new_var : The Updated Value of Variance
% Invoked As : [ new_mean , new_var ] = getUpdatedClusterMeanVarVal( prev_mean , prev_var , updateFactor , curr_x , v_d );

function [ new_mean , new_var ] = getUpdatedClusterMeanVarVal( prev_mean , prev_var , updateFactor , curr_x , v_d )

% Compute the Difference
diffVal = curr_x - prev_mean;

% Update the Mean
new_mean = prev_mean + ( updateFactor * diffVal );

% Update the Variance
diffValSqr = diffVal * diffVal;
new_var = ( 1.0 - updateFactor ) * ( prev_var + ( updateFactor * diffValSqr ) );

% Check the Variance
if new_var < v_d

  % Clip Variance
  new_var = v_d;
  
end


% Function for Updating Cluster Matrix
% Inputs :-
%	   prevClusterMatrix : The Previous Cluster Matrix
%	   curr_x : The Current Value of x
%	   currDataNum : The Current Data Number
%	   v_d : The Minimum and Default Cluster Variance
%	   lambda : The Chebyshev Inequality Parameter
%      alpha : The Weight Update Parameter
% Returns :-
%	   newClusterMatrix : The New Cluster Matrix
% Invoked As : newClusterMatrix = updateClusterMatrix( prevClusterMatrix , curr_x , currDataNum , v_d , lambda , alpha );

function newClusterMatrix = updateClusterMatrix( prevClusterMatrix , curr_x , currDataNum , v_d , lambda , alpha )

% Reading the Number of Clusters
[ r , prevClusterNum ] = size( prevClusterMatrix );
if ( r ~= 3 ) || ( prevClusterNum <= 0 )

  disp( '\n\nError in clusterMatrix Dimensions\n\n' );
  
end

% Copy the Previous Cluster Matrix to the New Cluster Matrix
newClusterMatrix = prevClusterMatrix;

% Compute the Membership Values and Normalised Distance Square Array
[ memValArray , normDistSqrArray ] = getMembershipArray( prevClusterMatrix , curr_x )

% Check if There are Indeed any Host Clusters
lambda_sqr = lambda * lambda;
indxSet_Host = find( normDistSqrArray <= lambda_sqr )
indxSet_Not_Host = find( normDistSqrArray > lambda_sqr );
hostClusterNum = length( indxSet_Host );
num_non_host = length( indxSet_Not_Host );

% Decide The Weight Update Factor
weightUpdateFactor = alpha;
if currDataNum < ceil( 1.0 / alpha )
    
    weightUpdateFactor = 1.0 / currDataNum;
    
end

% Penalize the Weights of All Non-Host Clusters
if num_non_host > 0
    
    % Looping Over the Non-Hosts
    for indxCount = 1 : num_non_host
        
        % Read the Cluster Index
        clusterIndx = indxSet_Not_Host( indxCount );
        
        % Penalize the Weight of Non-Host
        newClusterMatrix( 3 , clusterIndx ) = ( 1 - weightUpdateFactor ) * newClusterMatrix( 3 , clusterIndx );
        
    end
    
end

% CASE - 1 : THERE ARE HOST CLUSTERS
if hostClusterNum > 0
    
  % Loop Through the Host Clusters
  membershipSum = 0.0;
  for indxCount = 1 : hostClusterNum
  
    % Read the Host Cluster Index
    hostClusterIndx = indxSet_Host( indxCount );
    
    % Read the Mean, Variance and Membership Values
    prev_mean = prevClusterMatrix( 1 , hostClusterIndx );
    prev_var = prevClusterMatrix( 2 , hostClusterIndx );
    updateFactor = memValArray( 1 , hostClusterIndx );
    
    % Get the Updated Mean and Variance Values
    [ new_mean , new_var ] = getUpdatedClusterMeanVarVal( prev_mean , prev_var , updateFactor , curr_x , v_d );
    
    % Set the Updated Mean and Variance
    newClusterMatrix( 1 , hostClusterIndx ) = new_mean;
    newClusterMatrix( 2 , hostClusterIndx ) = new_var;
    
    % Update the Membership Sum
    membershipSum = membershipSum + memValArray( 1 , hostClusterIndx );
        
  end
  
  % Loop Through the Host Clusters for Weight Update
  for indxCount = 1 : hostClusterNum
  
    % Read the Host Cluster Index
    hostClusterIndx = indxSet_Host( indxCount );
  
    % Set the Cluster Specific Weight Update Factor
    clusterWeightUpdateFactor = weightUpdateFactor * ( memValArray( 1 , hostClusterIndx ) / membershipSum );

    % Update the Host Cluster Weight
    newClusterMatrix( 3 , hostClusterIndx ) = ( ( 1.0 - clusterWeightUpdateFactor ) * ( newClusterMatrix( 3 , hostClusterIndx ) ) ) + clusterWeightUpdateFactor;
    
  end
  
end
    
% CASE - 2 : THERE ARE NO HOST CLUSTERS
if hostClusterNum == 0
  
  % Add a New Cluster
  new_cluster = [ curr_x , v_d , 1.0 / currDataNum ]';
  newClusterMatrix( : , ( prevClusterNum + 1 ) ) = new_cluster;
  
end

% Normalizing the Weights
weightSum = sum( newClusterMatrix( 3 , : ) );
newClusterMatrix( 3 , : ) = newClusterMatrix( 3 , : ) / weightSum;


  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
    
    
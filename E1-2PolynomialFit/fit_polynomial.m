function [ params ,yCap ] = fit_polynomial( data, degree)
% Function which fits a polynomial in the given 1-D data
% data : [ X, Y ] each column is a sample
[ N , dim ] = size( data);


x1 = data(:,1);

y1 = data(:, 2);

Y = y1;

X = zeros( N , degree +1 );


for i = 1:1: degree 
    
       X(:, i) = x1.^( degree - i +1);
end

X( : , degree+1) = ones( N , 1);

params =  inv( X'*X)* X'*Y;

yCap =  X*params;
end
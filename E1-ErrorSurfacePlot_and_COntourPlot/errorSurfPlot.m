%###############################################################
%       ERROR SURFACE PLOT
%   Plot the error surface of the line y=2x+3 by varying the values of a nd
%   b in a range.
%   Also plot the contour of the error curve
%
%
%   WrittenBy : Mathew Francis
%   Revision History
%       Initial Draft : 10/08/2015
%

% x-values for the line
x=-10:0.1:10;
% standard deviation for adding random noise
sigma = 2;
y = zeros(1,length(x));
%corresponding y-valuesof the same line
for i=1:1:length(x)
    y(i)=2*x(i)+3 + sigma*rand(1);
end

% Range of values for a and b for the line y= ax+b
a = 0:0.1:5;
b = 0:0.1:5;

% Defining the combination of all the values of a nd b
[A,B] =meshgrid(a,b);

%Taking the dimension of the meshf=grid
[m,n] = size(A);

% Computing the error value for each pair of a and b
for i=1:1:m
    for j = 1:1:n
       Err=0;
        for k = 1:1: length(x)
            yCap = A(i,j)*x(k)+B(i,j);
            e= (yCap-y(k))^2;
            Err= Err + e;
        end
        ErrAvg(i,j) = Err/length(x);
    end
end

% Plot of hte error surface
surf(A,B,ErrAvg);
title('Errro Surface Plot')
xlabel('a-values');
ylabel('b-values');

figure;
%Contour PLot of the error curve
contour(a,b,ErrAvg,200);
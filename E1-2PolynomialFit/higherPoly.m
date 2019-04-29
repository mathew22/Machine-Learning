
close all;
clear all;
x1 = -10:0.1: 10;

% Curve fitting for higher degree polynomial



y =  0.1157*x1.*x1.*x1.*x1 + 3*x1.*x1.*x1  + 3* x1.*x1 -  2*x1 - 2 ;

mu = 50.0;
sigma = 125;

y1 = y + normrnd(mu,sigma,1, length( x1 ) );

data = [ x1',y1'];

[ params , yCap ]= fit_polynomial( data, 4 );



figure; 
plot( x1,y, 'Color', [ 0.0 , 01 , 0.0    ]);
hold on;
scatter( x1, y1 );
title('Curve Fitting')

pause( 2 );
% p = plot( x1,y1, 'Color', [ 0 , 0 , 1 ]);
pause( 3 );
% delete( p );


plot( x1,yCap, 'Color', [ 0 ,0 , 0 ]);

hold off;


% 

% xt  = 1:1:10;
% yt  = 2* xt + 3 ;
% yt = yt + normrnd(0 , 1 ,1, length( xt ));
% 
% data = [ xt', yt' ];
% errSurf = plotErrorSurface( data, 1 );







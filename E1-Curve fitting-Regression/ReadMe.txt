

[ x1,y1] = create_line( 1,0,0,10, 0, 0,50) : Creates the line with the parameters
[ a,b ] = line_fitting( x1,y1 ) : Estimates the parameters of the line

Note : Since no noise is added it should return the correct parameters.
=========================================================================
Now change the noise parameters and see how close the estimated parameters comes to the actual one


% In matrix formulation the parameters can be formulated as 
x=[ x1' , ones(length( x1) ,1)];
y = y1';


params = inv( x'*x )* x'*y;

a  =params [ 1];
b  =params [ 2 ];
===================
LinearReg.mat has  the saved workspace variables

Use the script higherPoly.m for polynomial filt of any degree




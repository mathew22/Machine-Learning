[ x1,y1] = create_line( 1,0,0,10, 0, 1,50); % Creates the line with the parameters
[ a,b ] = line_fitting( x1,y1 ); %  Estimates the parameters of the line
display ( a) 
display(b)

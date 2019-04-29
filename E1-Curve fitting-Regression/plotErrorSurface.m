function errSurf = plotErrorSurface( data, degree )

params = [ -10:1:10 ; -10:1:10 ];

[ N , c ] = size( data);

x1 = data( : ,1);

y = data( :, c );

X = zeros( N , degree +1 );


for i = 1:1: degree 
    
       X(:, i) = x1.^( degree - i +1);
end

X( : , degree+1) = ones( N , 1);

errSurf = zeros( size( params , 2 ) );

for i = 1:1: size( params, 2)
    for j  =1:1: size( params , 2 );
        
    params_tmp( 1, 1) = params( 1, i);
    params_tmp( 2, 1) = params( 2, j);
    yCap = X * params_tmp;
    diff = y -yCap;
    e = sum(diff.*diff);

    errSurf( i,j)  = e/N;

    end
end
    

x = -10:1:10 ;
y = -10:1:10 ;

[ xM , yM ] = meshgrid( x, y);
surf( xM, yM, errSurf)











end

%*************************************************************************
%                       GENETIC ALGORITHM
%
%Dveloped by:Mathew Francis
%Description: Program to implement the genetic algorithm
%Revision History:
%   Initial Draft:07/08/2014
%User defined functions used:
%   to_binary()-converts the integer value to binary
%**************************************************************************

    clear all;
    N=10;                                       %population size
    dimension=2;                                %dimension of the search space
    smin=[1;2];                                 %minimum boundary of the search space
    smax=[5;25];                                %maximum boundary of the search space
    m=max(smax);
    b=to_binary(m*100);
    L=length(b);                                %L is the length of the binary sequence
    %initial_population=zeros(dimension,N);
    initial_population=zeros(dimension,N);       %Generates a matrix of N vectors of mentioned dimension
    alpha=rand(2,N);                    %?should alpha besame across each dimension
    p=initial_population;
    cost_function=zeros(1,N);                   %Initializes a matrix which stores the cost function values corresponding to each sample in the population
    %----------creating the population from the mentioned search space
    for i=1:1:N
        p(:,i)=alpha(i).*smin+(1-alpha(i)).*smax;
        
    end
    %--------Convert the numbers into integers
    for i=1:1:N
        p(:,i)=int64(p(:,i)*100);
    end
    %---------Calculation of cost function
    for i=1:1:N
        for j=1:dimension:dimension
            cost_function(i)=p(j,i)*p(j+1,i);
        end       
    end
    %-------Binary equivalent of the population
    %used dec2bin(no,n) function
    population_binary=zeros(N,L);
    for i=1:1:N
        population_binary(i,:)=dec2bin(p(i),L);
    end
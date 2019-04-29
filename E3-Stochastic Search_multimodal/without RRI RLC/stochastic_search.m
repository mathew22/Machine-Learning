%*************************************************************************
%                STOCHASTIC SEARCH ALGORITHM
%
%Developed by:Mathew Francis
%Description:Program to implementat the stochastic search algorithm to find
%            the optimum value of the cost function. The cost function
%            used is a maximizing function. Maximize f(x,y)=xy;
%Revision History
%   Initial Draft:06/08/2014
%
%*************************************************************************   

    clear all;
    N=10;                                       %population size
    dimension=2;                                %dimension of the search space
    smin=[1;2];    %[xmin,ymin]                             %minimum boundary of the search space
    smax=[5;10];   %[xmax,ymax]                            %maximum boundary of the search space
    %initial_population=zeros(dimension,N);
    initial_population=zeros(dimension,N);       %Generates a matrix of N vectors of mentioned dimension
    alpha=rand(2,N);                    %?should alpha besame across each dimension
    p=initial_population;
    cost_function=zeros(1,N);               %Initializes a matrix which stores the cost function values corresponding to each sample in the population
    %----------creating the population from the mentioned search space
    for i=1:1:N
        p(:,i)=alpha(i).*smin+(1-alpha(i)).*smax;
        
    end
    %---------Calculation of cost function
    for i=1:1:N
        for j=1:dimension:dimension
            cost_function(i)=p(j,i)*p(j+1,i);
        end       
    end
    
   for iteration=1:1:25
        %--------Assign probability(weight to each of the samples in the
        %population depending on the value of the cost function
        min_cost=min(cost_function);                   
        cost_function1=cost_function-min_cost;               %subtracting the minimum value so as to make all the values positive so that the sum of the values won't become zero
        total_cost=sum(cost_function1);                      %sum of the costfunction values which is used for normalisation
        assigned_probability=cost_function1/total_cost;      %define probability from the cost function
        %---------Creating the new population
        lambda=0.02;                                        %It is a constant and it's selection depends on the domain knowledge
        cardinality_child=round(assigned_probability*N);    %number of childs which is to be selected from the viscinity of current sample
        %rand_direction=rand(1,dimension);
        s=sum(cardinality_child);
        new_population=zeros(dimension,s);
        newpop_cost_function=zeros(1,s);            %Iniialize the matrix which stores the value of the cost function of the new population.
        k=1;
        for i=1:1:N
            if cardinality_child(i)==0                      
                %exit();
            else
                for j=1:1:cardinality_child(i)
                    rand_direction=rand(1,dimension);       %
                    rand_direction=rand_direction/norm(rand_direction);
                    rand_direction=rand_direction';
                    new_sample=p(:,i)+lambda*(1-2*rand_direction);
                    if new_sample(1)<smin(1)
                        new_sample(1)=smin(1);
                    elseif new_sample(1)>smax(1)
                        new_sample(1)=smax(1);
                    end
                    if new_sample(2)<smin(2)
                        new_sample(1)=smin(2);
                    elseif new_sample(2)>smax(2)
                        new_sample(2)=smax(2);
                    end
                    new_population(:,k)=new_sample;
                    k=k+1;
                end           
            end        
        end
      %--------------Calculating the cost function for the new population  
        for i=1:1:s
            for j=1:dimension:dimension
                newpop_cost_function(i)=new_population(j,i)*new_population(j+1,i);
            end       
        end

        effective_population=[p,new_population];
        effective_cost_function_value=[cost_function,newpop_cost_function];
        [sorted_effective_cost_function_value,Index] = sort(effective_cost_function_value,'descend');
        next_gen_population=zeros(dimension,N);
        for i=1:1:N
            next_gen_population(:,i)=effective_population(:,Index(i));
        end

        cost_function=sorted_effective_cost_function_value(:,1:1:N);
        p=next_gen_population;
        %best_cost_of_generation=
        best_cost_of_generation(iteration)=cost_function(1);
        best_population_generation(:,iteration)=next_gen_population(:,1);
    end
    pos=next_gen_population(:,1)
    val=cost_function(1)
     %scatter(best_population_generation(1,:),best_population_generation(2,:))
    
    
    
 figure(1)
axis([4, 5, 0, 10])

x=best_population_generation(1,:);
y=best_population_generation(2,:); 
for k=1:1:length(x)%execute forloop alone without executingfigure2 and axis to mark the no's in figure 1
    text(x(k),y(k),'*')
    pause(1);
end
    
    
    
    

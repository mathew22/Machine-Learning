function [ cost ] = evalCost( population,mu,sigma )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    N=size(population);
    %cost=zeros(1,N(2));
    population=population-repmat(mu,1,N(2));
    
    tmp=population.*population;
    tmp(1,:)=tmp(1,:)/sigma(1,1);
    tmp(2,:)=tmp(2,:)/sigma(2,2);
    cost=sum(tmp,1);
    cost=cost*-1;
    
%     for i=1:1:N(2)
%         for j=1:N(1):N(1)
%             cost(i)=population(j,i)*population(j+1,i);
%         end       
%     end

end


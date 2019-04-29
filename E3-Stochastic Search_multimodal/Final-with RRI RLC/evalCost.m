function [ cost ] = evalCost( population,mu,sigma )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    N=size(population);
    
    population2 = population;
    %cost=zeros(1,N(2));
    population=population  +5;% repmat(-5,1,N(2)) ;
    population2=population2-8;%repmat(8,1,N(2)) ;
    
    
    tmp1=population.*population;
    tmp1(1,:)=tmp1(1,:)/sigma(1,1);
    tmp1(2,:)=tmp1(2,:)/sigma(2,2);
    
    cost1=sum(tmp1,1);
    cost1=cost1*1;
    
    tmp2=population2.*population2;
    tmp2(1,:)=tmp2(1,:)/sigma(1,1);
    tmp2(2,:)=tmp2(2,:)/sigma(2,2);
    
    
    cost2=sum(tmp2,1);
    cost2=cost2*1;
    
    %tmp(1,:)=tmp1(1,:).*tmp2(1,:);
    %tmp(2,:)=tmp1(2,:).*tmp2(2,:);
    
    cost =cost1.*cost2;
    cost=cost*-1;
    
    
%     for i=1:1:N(2)
%         for j=1:N(1):N(1)
%             cost(i)=population(j,i)*population(j+1,i);
%         end       
%     end

end


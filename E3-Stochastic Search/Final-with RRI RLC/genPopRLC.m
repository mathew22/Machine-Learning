function [ newPopRLC ] = genPopRLC(population, sMin,sMax,nRLC )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
   l=size(population);
   newPopRLC=zeros(l(1),nRLC);
   for i=1:1:nRLC
       alpha=rand(1,2);
       alpha=alpha';
       index=round(alpha*1+([1;1]-alpha).*l(2));
       newSample=alpha.*population(index(1))+([1;1]-alpha).*population(index(2));
       [ newSample ] = boundCheck(newSample, sMin,sMax );%this is require??it will be a point in between
        newPopRLC(:,i)=newSample;
   end
   


end


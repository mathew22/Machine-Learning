function [ selectedPointIndex,selectedPoint,selIndex1,selIndex2 ] = selectSample( population,pIndex1,pIndex2)
%THis function selects two indexes excluding pIndex1 and pIndex2 and select
%the best one from the  population corresponding to the best cost
%   

    s=size(population);
    length=s(2);            %no of elements in the population
    %alpha=rand(1,2);
    selIndex1=pIndex1;
    selIndex2=pIndex2;
    while (selIndex1==pIndex1 || selIndex2==pIndex2 ||selIndex1==pIndex2 || selIndex2==pIndex1)
        alpha=rand(1,2);
        selIndex1=round(alpha(1)+(1-alpha(1))*length);
        selIndex2=selIndex1;
        while selIndex2==selIndex1            %to make sure that the two numbers aredifferent
            alpha=rand(1,2);
            selIndex2=round(alpha(2)+(1-alpha(2))*length);
        end
    end

    cost1=evalCostFun(population(:,selIndex1));
    cost2=evalCostFun(population(:,selIndex2));
    if cost1>cost2
        selectedPoint=population(:,selIndex1);
        selectedPointIndex=selIndex1;
    else
        selectedPoint=population(:,selIndex2);
        selectedPointIndex=selIndex2;
    end


end


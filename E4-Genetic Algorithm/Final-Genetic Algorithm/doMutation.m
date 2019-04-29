function [ c ] = doMutation( ipNum )
%Performs mutation on the given binary number
%   Detailed explanation goes here

    seqLength=length(ipNum);
    ipNo=ipNum(2:seqLength);
    seqLength=seqLength-1;      %to avoid the sign bit;
    alpha=rand(1,1);
    %if length(ipNo2)==length(ipNo1)
        mutationPosition=round(alpha+(1-alpha)*seqLength);
    
    %tmp=ipNo1;
    if ipNo(mutationPosition)==0
        ipNo(mutationPosition)=1;
    else
        ipNo(mutationPosition)=0;
    end
        
    %ipNo2(mutationPosition)=tmp(mutationPosition);
    c=bi2de(fliplr(ipNo));
    %d=bi2de(fliplr(ipNo2));
    %end
    if ipNum(1)==1
        c=c*-1;
    end

end


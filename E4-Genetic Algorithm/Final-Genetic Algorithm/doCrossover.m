function [ c,d ] = doCrossover( ipNum1,ipNum2 )
%Performs crossover operation on the input binary numbers and returns it's
%integer equivalent.
%   Detailed explanation goes here
    
    seqLength=length(ipNum1);
    ipNo1=ipNum1(2:seqLength);
    ipNo2=ipNum2(2:seqLength);
    seqLength=seqLength-1;      %to avoid the sign bit
    alpha=rand(1,1);
    if length(ipNo2)==length(ipNo1)
        crossoverPosition=round(alpha+(1-alpha)*seqLength);
    
    tmp=ipNo1;
    ipNo1(crossoverPosition:seqLength)=ipNo2(crossoverPosition:seqLength);
    ipNo2(crossoverPosition:seqLength)=tmp(crossoverPosition:seqLength);
    c= bi2de(fliplr(ipNo1));
    d= bi2de(fliplr(ipNo2));
    if ipNum1(1)==1
        c=c*-1;
    end
    if ipNum2(1)==1
        d=d*-1;
    end
    end
end


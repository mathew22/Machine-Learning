function [ output_args ] = perfAnalysis( noOfItr,gammaInterval )
%UNTITLED2 Summary of this function goes here
%   perfAnalysis( 5,.1 )
    
    gamma=0:gammaInterval:.7;
    l=length(gamma);
%     MSE=zeros(noOfItr,l);
    param=zeros(noOfItr,l);
%     count=zeros(noOfItr,l);
    a=1;
    b=1;
    for i=1:1:noOfItr
        for j=1:1:l
       [ a1 b1 ]=IRWLS(-20, 20, 60, a, b,gamma(j) );
%         MSE(i,j)=MSE1;
        param(i,j)=max(abs((a-a1)/a),abs((b-b1)/b));
%         count(i,j)=count1;
        end
    end
    
%     sMSE=(sum(MSE,1))./noOfItr;
    sParam=(sum(param,1))./noOfItr;
%     sCount=(sum(count,1))./noOfItr;
    figure;    
%     subplot(3,1,1);plot(gamma,log(sMSE));
%     title('Gamma vs MSE');
%     subplot(3,1,2);
    plot(gamma,sParam);
    title('Gamma vs change in model parameters');
%     subplot(3,1,3);plot(gamma,sCount);
%     title('Gamma vs No of iterations');
end


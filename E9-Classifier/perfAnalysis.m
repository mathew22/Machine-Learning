function [ output_args ] = perfAnalysis( N,mu,r1,r2,r3 )
%The function generates an roc curve for a simple classifier based on
%Chebyshev inequality

%   perfAnalysis( 50,[0;0],5,10,20 )for non overlapping data andperfect ROC
%   perfAnalysis( 250,[0;0],5,4,8 ) for overlapping data and ROC
    k=1:.1:10;
    TPR=zeros(1,length(k));
    FPR=zeros(1,length(k));
    
%     [ pointsObject ] = genPoints( r1,N,mu );
%     Or 
    pointsObject=genrandomPoints( 0,r1,N,mu  );
%     [ ringPoints ] = genRingPoints( r2,r3,mu,N );
%     Or
    ringPoints=genrandomPoints( r2,r3,N,mu  );
    for i=1:1:length(k)
        [tpr1 fpr1]= simpleClassifier(pointsObject,ringPoints,k(i),N);
        TPR(i)=tpr1;
        FPR(i)=fpr1;
    end
     legend('Object Data','Non Object Data');
    figure;plot(FPR,TPR);
    xlabel('False Positive Rate');
    ylabel('True Positive Rate');
    title('ROC Curve');
end


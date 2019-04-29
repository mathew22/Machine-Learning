function [ TPR FPR ] = simpleClassifier( objectData,nonObjectData,k,N)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   N=10;
%   muArray=repmat(mu,1,N);
%   sigmaArray=repmat(sigma,1,N);
%   positive=normrnd(muArray,sigmaArray);
%   negative=normrnd(muArray,3*sigmaArray);


% [ pointsObject ] = genPoints( r1,N,mu );
%     [ pointsRing ] = genPoints( r2-r1,N,mu );
%     pointsRing=pointsRing+repmat(r1,length(mu),N);
%     [ pointsNoObject ] = genPoints( r3-r2,N,mu );
%     pointsNoObject1=pointsNoObject;
%     for i=1:1:N
%         sgn=sign((pointsNoObject(:,i)-mu));
%         pointsNoObject1(:,i)=pointsNoObject(:,i)+sgn*r2;
%     end
    


% [ ringPoints ] = genRingPoints( r2,r3,mu,N );
    pointsObject=    objectData;
    ringPoints=nonObjectData;
    meanObject=mean(pointsObject,2);
    tmp=pointsObject';
    stdObject=std(tmp);
    scatter(pointsObject(1,:),pointsObject(2,:),'b');
    hold on;
%     scatter(pointsRing(1,:),pointsRing(2,:),'r');
%     hold on;
%     scatter(pointsNoObject(1,:),pointsNoObject(2,:),'k');
    scatter(ringPoints(1,:),ringPoints(2,:),'m');
%     text(mu(1),mu(2),'C');
    
%     legend('Object Data','Non Object Data');
    title('Data');
    label=[ones(1,N) zeros(1,N)];
    groundTruth=[pointsObject ringPoints];
    groundTruth=[groundTruth;label];
    algDecisionLabel=zeros(1,2*N);
    
    for i=1:1:2*N
        
        xLogic=(groundTruth(1,i)-meanObject(1))^2;
        yLogic=(groundTruth(2,i)-meanObject(2))^2;
        if ((xLogic<=k*k*stdObject(1)*stdObject(1)) && (yLogic<=k*k*stdObject(2)*stdObject(2)))
            algDecisionLabel(i)=1;
        end
    end
    TP=0;
    FP=0;
    TN=0;
    FN=0;
     for i=1:1:2*N
         
         if groundTruth(3,i)==1 && algDecisionLabel(i)==1
             TP=TP+1;
         elseif groundTruth(3,i)==1 && algDecisionLabel(i)==0
             FN=FN+1;
          elseif groundTruth(3,i)==0 && algDecisionLabel(i)==0
             TN=TN+1;
             elseif groundTruth(3,i)==0 && algDecisionLabel(i)==1
             FP=FP+1;
         end
     end
     TPR=TP/(TP+FN);
     FPR=FP/(FP+TN);
     
             
        
    
    


end


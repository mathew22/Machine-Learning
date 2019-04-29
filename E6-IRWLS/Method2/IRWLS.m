function [ aCap bCap ] = IRWLS(xMin,xMAx,noOfPoints,a,b,gamma )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% IRWLS(-20, 20, 60, 1, 0, 0.2)
%     clear all;
%     a=1;
%     b=0;
    [xVal,yValNoNOise,yValNoise,yValWithOutliers,weight ]  =dataGenForIRLS( xMin,xMAx,noOfPoints,a,b,gamma);
    p1=plot(xVal,yValNoNOise,'g');
    hold on;
    s1=scatter(xVal,yValWithOutliers,'b');
    %    mean(yValNoise-yValNoNOise)
    [ a0,b0] = weightedLineFitting( weight,xVal,yValWithOutliers );
    [ yEstimated ] = evalY( xVal,a0,b0,0,0);
    initialPoint=[ a0;b0];
%     p2=plot(xVal,yEstimated,'k');
%     legend('model Data without Noise','Data with outliers','Estimated Line');
    Itr=1000;
    weightItr=zeros(Itr,60);
    aItr=zeros(Itr,1);
    bItr=zeros(Itr,1);
    count=0;
 for i=1:1:Itr
        [aCap,bCap]=lineFitGradientDesc(xVal,yValNoNOise,yValWithOutliers, weight, a0,b0 );
        [ yEstimated ] = evalY( xVal,aCap,bCap,0,0);
%         [ yEstimated ] = evalY( xVal,a0,b0,0,0);
        error=yValWithOutliers-yEstimated;
        error1=yValNoNOise-yEstimated;
        u=1./(error+.01);
        u=abs(u);
        weight=u/sum(u);
        E=sum(weight.*(error.*error));
        E1=sum(weight.*(error1.*error1));
        weightItr(i,:)=weight(1,:);
        aItr(i,1)=aCap;
        bItr(i,1)=bCap;
        count=count+1;
        if E1<10^-4
           break;
        else
        a0=aCap;
        b0=bCap;
        end
   
 end
 
 
   pn= plot(xVal,yEstimated,'r');
    legend('model Data without Noise','Data with outliers','Final Estimated Line');
    xlabel('x-value');
    ylabel('y-value');
    title('IRWLS Algorithm');
    index=1:1:count;
 figure;plot(index,aItr,'m');
 hold on;
 plot(index,bItr,'b');
 legend(['Parameter a (Actual Value)' int2str(a)] ,['Parameter b(Actual Value)' int2str(b)]);
 title('Variation of model parameters a and b');
end


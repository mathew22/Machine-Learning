function [ output_args ] = meanShiftClustering( img,h )
%meanShiftClustering
%   INPUT VARIABLES
%       img:-Input image
%       h:-bandwidth for the kernel 
%   OUTPUT VARIABLES
%   Eg:-meanShiftClustering( test,20 )

    I                   = double(img);              %Converting from uint8 to double data format
    [r c]               = size(I);                  %Dimension of the input image
    sequence            = I(:);                     %Converting the sequence into a single dimensional array
    minLimit            = 0;                        %min valu of thedomain of the kernel density estimate
    maxLimit            = 255;
%     xVal                = (minLimit):1:(maxLimit);
%     rangeLength         = length(xVal);
    seqLength           = length(sequence);
    seqDistinct         = unique(sequence);
    lDistnct            = length(seqDistinct);
    convergenceValue    = zeros(1,seqLength);
    kernelDensityValue  = 0;
    kernelDensityValueX = 0;
%     filterCoeff         = exp(-1*xVal);
    
%     kernel              = conv(xVal, filterCoeff);          
    
    %Kernel density Estimation-Non parametric method. Obtained by putting a
    %kernel density function at every data point and finally summing it at
    %every point
    kernelDensityEstimate=zeros(1,seqLength);
    for i=1:1:seqLength
        for j=1:1:seqLength
            kernelDensityEstimate(sequence(i))=kernelDensityEstimate(sequence(i))+exp(-1*((sequence(i)-sequence(j))^2)/(2*h*h));
        end
    end
    kernelDensityEstimate=kernelDensityEstimate/seqLength; 
    
  %Corresponding to intensity point in the given sequence do a gradient 
  %ascent and find out the value of it's convergence.
  %The intensity points which converges to the same maxima can be considered as a single grouo 
  
%   kernelDensityValue=zeros(1,seqLength);
%   kernelDensityValueX=zeros(1,seqLength);

    for i=1:1:lDistnct
          startPoint=seqDistinct(i);  
          for j=1:1:seqLength;

                startPoint=sequence(i);
                for j=1:1:seqLength
                    tmp(j)=kernelDensityEstimate(abs(round(startPoint-sequence(j))));
                     kernelDensityValue=kernelDensityValue+tmp(j);
                    kernelDensityValueX=kernelDensityValueX+sequence(j)*tmp(j);
                end
                numerator=kernelDensityValueX;
                denominator=kernelDensityValue;
                newPoint=numerator/denominator;
          end
    
        
        
%         kernelDensityValue=exp(-1*((sequence-startPoint).^2)/(2*h*h));
%         kernelDensityValue=kernelDensityEstimate(sequence);
        for j=1:1:seqLength
            tmp(j)=exp(-1*((startPoint-sequence(j))^2)/(2*h*h));
             kernelDensityValue=kernelDensityValue+tmp(j);
            kernelDensityValueX=kernelDensityValueX+sequence(j)*tmp(j);
        end
%              numerator=sum(sequence.*kernelDensityValue);
%         denominator=sum(kernelDensityValue);
    numerator=kernelDensityValueX;
    denominator=kernelDensityValue;
        newPoint=numerator/denominator;
        signForCheck=sign(newPoint-startPoint);
        point=newPoint;
        diff=100;
        
        while 1==1
            
%             kernelDensityValue=exp(-1*((sequence-point).^2)/(2*h*h));
%             numerator=sum(sequence.*kernelDensityValue);
%             denominator=sum(kernelDensityValue);
             kernelDensityValue=0;
            kernelDensityValueX=0;
            for j=1:1:seqLength
                tmp(j)=exp(-1*((point-sequence(j))^2)/(2*h*h));
                kernelDensityValue=kernelDensityValue+tmp(j);
                kernelDensityValueX=kernelDensityValueX+sequence(j)*tmp(j);
            end
            
            numerator=kernelDensityValueX;
            denominator=kernelDensityValue;
           newPoint=numerator/denominator;
            signValue=sign(newPoint-point);
            diff=newPoint-point;
            if signValue==signForCheck && abs(diff)>0.1
                
                
                point=newPoint;
            else
                break;
            end
           
        end
         convergence(i)=point;

    end
    figure;
   subplot(1,3,1);imshow(img);
   subplot(1,3,2);imhist(img);
%    subplot(1,3,3);plot(xVal,kernelDensityEstimate); 
        end


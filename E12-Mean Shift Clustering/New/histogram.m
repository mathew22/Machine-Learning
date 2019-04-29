
[ imageHistogram ]                          = histigramCalc( I );
h                                           = 30;
[ distinctIntensityVal intensityDensityFn ] = IntensityDensityEstimate( I,h );
figure;plot(distinctIntensityVal ,intensityDensityFn);

%Gradient Ascent Part
l                                           = length(distinctIntensityVal);

diffInIntensity                             = 0:1:255;
exponentLookup                              = exp(-1*(diffInIntensity.*diffInIntensity)./(2*h*h));
convergenceVal                              = zeros(1,l);
[r c]                                       = size(I);
for i=1:1:l
    startValue = distinctIntensityVal(i);
    
    s=0;
%     for j=1:1:l
        tmp             = imageHistogram(2,distinctIntensityVal+1)'.*exp(-1*((startValue-distinctIntensityVal).^2/(2*h*h)));%exponentLookup(abs((startValue-distinctIntensityVal(j)))+1);
        nr              = sum(distinctIntensityVal.*tmp);
        dr              = sum(tmp);
        newValue        = nr/dr;
        signOfChange    = sign(newValue-startValue);
        diff            = (newValue-startValue);
        startValue      = newValue; 
        if abs(diff)>0.1
            
            diff =100;
            while diff>0.01

    %            newValue = imageHistogram(2,distinctIntensityVal(j)+1)*exp(-1*((startValue-distinctIntensityVal(j))^2/(2*h*h)));%exponentLookup(abs((startValue-distinctIntensityVal(j)))+1);
               tmp          = imageHistogram(2,distinctIntensityVal+1)'.*exp(-1*((startValue-distinctIntensityVal).^2/(2*h*h)));%exponentLookup(abs((startValue-distinctIntensityVal(j)))+1);
               nr           = sum(distinctIntensityVal.*tmp);
               dr           = sum(tmp);
               newValue     = nr/dr;
               signCheck    = sign(newValue-startValue);
               diff         = (newValue-startValue);
               if signCheck==signOfChange && abs(diff)>0.01
                   startValue = newValue; 
               end
            end
        end
%     end
  convergenceVal(i) = newValue;  
end

 modes=unique(round(convergenceVal));
 modes1=modes;
 for i=1:1:length(modes)
     for j=i+1:1:length(modes)
         if mode(i)~=0 && abs(modes(i)-modes(j))<=10
            
            modes(j)=300;
         end
     end
 end
 newConvergenceVal=convergenceVal;
 %Eliminate duplicates(neareby convergence points) from the converge list
 for i=1:1:length(convergenceVal)
     for j=1:1:length(modes)
         if modes(j)~=300 && (abs(convergenceVal(i)-modes(j))<=20)
             newConvergenceVal(i)=modes(j);
         end
     end
 end
 
 %Change the intensity values to the convergedvalues
 I1=zeros(r,c);
 for i=1:1:r
     for j=1:1:c
         for k=1:1:l
              if I(i,j)==distinctIntensityVal(k)
                  I1(i,j)= newConvergenceVal(k);
              end
         end
     end
 end
     
 imshow(I1);
           
        
    
plot(distinctIntensityVal,intensityDensityFn);



%figure;imhist(test);


























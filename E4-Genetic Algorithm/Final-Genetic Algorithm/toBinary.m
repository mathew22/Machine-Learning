function [ binNo ] = toBinary( number,l )
%This function accepts an integer value and returns the binary equivalent
%in array format
%   a is the input integer
%   l is the no of bits for the binary representation
%if the no of bits given to the function is less than the number of bits
%required for the representation then it will use that required no of bits

 % 
     %Calculate the no of bits required for the binary representation
     no=number;
     if no<0
         no=no*-1;
     end
     n=1;
       while (no-2^n)>0 || (no-2^n)==0
           n=n+1;
       end

       length=n;
       binNo=zeros(1,length);
        i=1 ;  
       while i<=length
            r=mod(no,2);                     %calculate the remainder
            binNo(1,length-i+1)=floor(r);
            no=no/2;
            i=i+1;
       end
       %check whether the specified length is larger that  the requied no of
       %bits. in that case add zeros in the extra bit positions.
       if l>length
           binEqu=zeros(1,l);
           for i=l:-1:l-n+1
            binEqu(i)=binNo(i-(l-n));
           end
           binNo=binEqu;
       end
        
       %Addiing the sign bit
       if number<0
           binNo=[1 binNo];
       else
           binNo=[0 binNo];
       end
       
    
end


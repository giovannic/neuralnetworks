function [ e1, t1, e2, t2, e3, t3, e4, t4, e5, t5, e6, t6 ] = split_data( annexamples, anntargets )
%Splits the examples into the example for each emotion 

%DONT EVER EVER USE THIS IT IS WRONG!

e1 = []; e2 = []; e3 = []; e4 = []; e5 = []; e6 = [];
t1 = []; t2 = []; t3 = []; t4 = []; t5 = []; t6 = [];

for i = 1:length(annexamples)
   switch find(anntargets, 1)
       case 1
        e1 = [e1, annexamples(:, i)];
        t1 = [t1; 
       case 2
        e2 = [e2, annexamples(:, i)];         
       case 3
        e3 = [e3, annexamples(:, i)];         
       case 4
        e4 = [e4, annexamples(:, i)];        
       case 5
        e5 = [e5, annexamples(:, i)];          
       otherwise
        e6 = [e6, annexamples(:, i)];     
   end
end
end


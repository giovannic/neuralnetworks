function [ nets ] = create_six_single( inputs, targets )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


% Will be turned into a length 6 vector contraining 6 networks 


for i = 1:size(y2, 1)
    subtargets = targets(i, :);
    nets(i)    = feedforwardnet(10); 
    nets(i)    = configure(nets(i), inputs, subtargets);
    nets(i)    = train(nets(i), inputs, subtargets);
end

end


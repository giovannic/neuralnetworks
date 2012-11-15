function [ net ] = create_six_output( inputs, targets, num_layers, num_neurons)
    
%from lectures: 'networks with many hidden layers are prone to overfitting'
%               'for more problems one hidden layer should be enough'
%               '2 hidden layers can sometimes lead to improvement'
if nargin < 6
    num_layers = 1;
    num_neurons = 10;
    training_fn = 'trainlm';
    transfer_fn = 

net = feedforwardnet(10); 
net = configure(net, inputs, targets);

%Returns the network untrained

end


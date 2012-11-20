function [ net ] = build_network_gio(train_ex, train_targ, params)
% params [1,2] = topology, [3,4,5] = transfer fn1,2,3, 6 = training fn, 7 = max epochs, 8 = learning rate, 9 = momentum
    %transfer_functions = {'compet';'hardlim';'hardlims';'logsig';'netinv';'poslin';'purelin';'radbas';'radbasn';'satlin';'satlins';'softmax';'tansig';'tribas'};
    transfer_functions = {'hardlim';'logsig';'purelin'};
    training_functions = {'trainbfg','traincgb','traincgf','traincgp','traingda','traingdm','traingdx','trainlm','trainoss','trainrp','trainscg'};
    
    dimensions = params(1:2);
    
    net = feedforwardnet(dimensions(dimensions ~= 0));
    net = configure(net, train_ex, train_targ);
    
    transfer_function_layer(1) = params(3);
    transfer_function_layer(2) = params(4);
    transfer_function_layer(3) = params(5);
    training_function = params(6);
    net.trainFcn = training_functions{training_function};
    for i = 1:length(net.layers)
        net.layers{i}.transferFcn = transfer_functions{transfer_function_layer(i)};
    end
    net.trainParam.epochs = params(7);
    net.trainParam.lr = params(8);
    net.trainParam.mu = params(9);
    net.trainParam.time = 60;
    
    net.trainParam.showWindow = 0;
    
    net = train(net, train_ex, train_targ);
end

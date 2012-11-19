function [ net ] = build_network(train_ex, train_targ, params)
    transfer_functions = {'compet';'hardlim';'hardlims';'logsig';'netinv';'poslin';'purelin';'radbas';'radbasn';'satlin';'satlins';'softmax';'tansig';'tribas'};
    training_functions = {'trainbfg';'trainbr';'traincgb';'traincgf';'traincgp';'traingd';'traingda';'traingdm';'traingdx';'trainlm';'trainoss';'trainrp';'trainscg'};
    
    dimensions = params(1:2);
    
    net = feedforwardnet(dimensions(dimensions ~= 0));
    net = configure(net, train_ex, train_targ);
    
    transfer_function = params(3);
    training_function = params(4);
    net.trainFcn = training_functions{training_function};
    for i = 1:length(net.layers)
        net.layers{i}.transferFcn = transfer_functions{transfer_function};
    end
    net.trainParam.epochs = params(5);
    net.trainParam.lr = params(6);
    net.trainParam.mu = params(7);
    
    net.trainParam.showWindow = 0;
    
    net = train(net, train_ex, train_targ);
end
function [ net ] = build_network_6(train_ex, train_targ, params)
% params [1,2] = topology, [3,4,5] = transfer fn1,2,3, 6 = training fn, 7 = max epochs, 8 = learning rate, 9 = momentum
    %transfer_functions = {'compet';'hardlim';'hardlims';'logsig';'netinv';'poslin';'purelin';'radbas';'radbasn';'satlin';'satlins';'softmax';'tansig';'tribas'};
    transfer_functions = {'logsig';'purelin'};
    training_functions = {'trainbfg','traincgb','traincgf','traincgp','traingda','traingdm','traingdx','trainlm','trainoss','trainrp','trainscg'};
        
    dimensions = params(1:2);
    transfer_function_layer(1) = params(3);
    transfer_function_layer(2) = params(4);
    transfer_function_layer(3) = params(5);
    training_function = params(6);
    
    for emotion = 1:6
        targs = find_ann_emotion(train_targ, emotion);
        net{emotion} = feedforwardnet(dimensions(dimensions ~= 0));
        net{emotion} = configure(net{emotion}, train_ex, targs);

        net{emotion}.trainFcn = training_functions{training_function};
        for i = 1:length(net{emotion}.layers)
            net{emotion}.layers{i}.transferFcn = transfer_functions{transfer_function_layer(i)};
        end
        net{emotion}.trainParam.epochs = params(7);
        net{emotion}.trainParam.lr = params(8);
        net{emotion}.trainParam.mu = params(9);
        net{emotion}.trainParam.time = 60;

        net{emotion}.trainParam.showWindow = 0;
           
        net{emotion} = train(net{emotion}, train_ex, targs);
    end
end
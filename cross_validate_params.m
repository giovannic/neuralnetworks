function [ predictions, f1s ] = cross_validate_params(examples, targets, params)
disp('--------------Cross Validate-----------------');
predictions     = [];

num_folds       = 10;
fold_size       = floor(length(examples) / num_folds);
remainder       = length(targets) - (num_folds * fold_size);

start_test_data = 1;
stop_test_data  = fold_size;

results = [];

f1s = zeros(10,6);

for i = 1:num_folds
    [r1, r2] = removerows(examples, 'ind', [start_test_data:stop_test_data]);
    [r3, r4] = removerows(targets, 'ind', [start_test_data:stop_test_data]);   
    
    %Raw data
    [sub_training_examples, sub_training_targets]  = ANNdata(r1, r3); 
    [sub_testing_examples, sub_testing_targets] = ANNdata(removerows(examples, 'ind', r2.keep_ind),removerows(targets, 'ind', r4.keep_ind));
                                                          
    %Converted format data
    
    %configure
    transfer_functions = {'hardlim';'logsig';'purelin'};
    training_functions = {'trainbfg','traincgb','traincgf','traincgp','traingda','traingdm','traingdx','trainlm','trainoss','trainrp','trainscg'};
    
    dimensions = params(1:2);
    
    net = feedforwardnet(dimensions(dimensions ~= 0));
    net = configure(net, sub_training_examples, sub_training_targets);
    
    transfer_function_layer(1) = params(3);
    transfer_function_layer(2) = params(4);
    transfer_function_layer(3) = params(5);
    training_function = params(6);
    net.trainFcn = training_functions{training_function};
    for layer = 1:length(net.layers)
        net.layers{layer}.transferFcn = transfer_functions{transfer_function_layer(layer)};
    end
    net.trainParam.epochs = params(7);
    net.trainParam.lr = params(8);
    net.trainParam.mu = params(9);
    %end configure
    
    
    net    = train(net, sub_training_examples, sub_training_targets);
    new_preds = NNout2labels(sim(net, sub_testing_examples));
    predictions = [predictions; new_preds];
    
    start_test_data = start_test_data + fold_size;
    stop_test_data  = stop_test_data + fold_size;
    
    f1s(i, :) = f1(new_preds, NNout2labels(sub_testing_targets));
end
disp('------------------------------------------------');
end


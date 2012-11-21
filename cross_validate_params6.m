function [ predictions, f1s ] = cross_validate_params6(examples, targets, params)
disp('--------------Cross Validate-----------------');
predictions     = [];

num_folds       = 10;
fold_size       = floor(length(examples) / num_folds);
remainder       = length(targets) - (num_folds * fold_size);

start_test_data = 1;
stop_test_data  = fold_size;

results = [];

f1s = zeros(10,6);

for fold = 1:num_folds
    [r1, r2] = removerows(examples, 'ind', [start_test_data:stop_test_data]);
    [r3, r4] = removerows(targets, 'ind', [start_test_data:stop_test_data]);   
    
    %Raw data
    [sub_training_examples, sub_training_targets]  = ANNdata(r1, r3); 
    [sub_testing_examples, sub_testing_targets] = ANNdata(removerows(examples, 'ind', r2.keep_ind),removerows(targets, 'ind', r4.keep_ind));
                                                          
    %Converted format data
    
    %configure
    transfer_functions = {'logsig';'purelin'};
    training_functions = {'trainbfg','traincgb','traincgf','traincgp','traingda','traingdm','traingdx','trainlm','trainoss','trainrp','trainscg'};
        
    dimensions = params(1:2);
    transfer_function_layer(1) = params(3);
    transfer_function_layer(2) = params(4);
    transfer_function_layer(3) = params(5);
    training_function = params(6);
    
    ps = zeros(6, fold_size);
    
    for emotion = 1:6
        training_targets = find_ann_emotion(sub_training_targets, emotion);
        testing_targets = find_ann_emotion(sub_testing_targets, emotion);
        
        net{emotion} = feedforwardnet(dimensions(dimensions ~= 0));
        net{emotion} = configure(net{emotion}, sub_training_examples, training_targets);

        net{emotion}.trainFcn = training_functions{training_function};
        for i = 1:length(net{emotion}.layers)
            net{emotion}.layers{i}.transferFcn = transfer_functions{transfer_function_layer(i)};
        end
        net{emotion}.trainParam.epochs = params(7);
        net{emotion}.trainParam.lr = params(8);
        net{emotion}.trainParam.mu = params(9);
        net{emotion}.trainParam.showWindow = 0;
        
        net{emotion} = train(net{emotion}, sub_training_examples, training_targets);
        store = sim(net{emotion}, sub_testing_examples);
        ps(emotion, :) = store;
        
    end
    %end configure
    
    comb_ps = combine_answers(ps);
    predictions = [predictions, comb_ps];
    start_test_data = start_test_data + fold_size;
    stop_test_data  = stop_test_data + fold_size;
    
    f1s(fold, :) = f1(comb_ps, NNout2labels(sub_testing_targets));
    
end
disp('------------------------------------------------');
end

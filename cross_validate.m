function [ predictions ] = cross_validate(examples, targets, net)
disp('--------------Cross Validate-----------------');
predictions     = [];

num_folds       = 10;
fold_size       = floor(length(examples) / num_folds);
remainder       = length(targets) - (num_folds * fold_size);

start_test_data = 1;
stop_test_data  = fold_size;

results = [];

for i = 1:num_folds
    [r1, r2] = removerows(examples, 'ind', [start_test_data:stop_test_data]);
    [r3, r4] = removerows(targets, 'ind', [start_test_data:stop_test_data]);   
    
    %Raw data
    [sub_training_examples, sub_training_targets]  = ANNdata(r1, r3); 
    [sub_testing_examples, sub_testing_targets] = ANNdata(removerows(examples, 'ind', r2.keep_ind),removerows(targets, 'ind', r4.keep_ind));
                                                          
    %Converted format data
    
    net    = train(net, sub_training_examples, sub_training_targets);
    predictions = [predictions; NNout2labels(sim(net, sub_testing_examples))];
    
    start_test_data = start_test_data + fold_size;
    stop_test_data  = stop_test_data + fold_size;
    
    %Adds any remainder on to the end could greatly effect it in the data
    %set is smaller
    if i == (num_folds - 1)
        stop_test_data = stop_test_data + remainder;
    end
end
disp('------------------------------------------------');
end


function [ f ] = fitness(x2, y2, params)
    examples = length(y2);
    boundary = ceil(0.6 * examples);

    train_examples = x2(:,1:boundary);
    train_targets = y2(:,1:boundary);
    testing_examples = x2(:,(boundary + 1):examples);
    testing_targets = y2(:,(boundary + 1):examples);
    
    n = build_network_gio(train_examples,train_targets, params);
    predictions = sim(n, testing_examples);
    f = f1(NNout2labels(predictions), NNout2labels(testing_targets));
    f = 100 - mean(f);
    disp(f);
end
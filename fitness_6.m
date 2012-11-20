function [ f ] = fitness_6(x2, y2, params)
    examples = length(y2);
    boundary = ceil(0.6 * examples);

    train_examples = x2(:,1:boundary);
    train_targets = y2(:,1:boundary);
    testing_examples = x2(:,(boundary + 1):examples);
    testing_targets = y2(:,(boundary + 1):examples);
    
    n = build_network_6(train_examples,train_targets, params);
    
    predictions = zeros(6, examples - boundary);
    
    for emotion = 1:6
        predictions(emotion, :) = sim(n{emotion}, testing_examples);
    end
    
    ps = combine_answers(predictions);
    tt = NNout2labels(testing_targets);
    f = f1(ps, tt);
    f = 100 - mean(f);
    disp(f);
end
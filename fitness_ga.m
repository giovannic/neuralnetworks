function [ f ] = fitness_ga(x2, y2, network)
    examples = length(y2);
    boundary = ceil(0.66 * examples);

    testing_examples = x2(:,(boundary + 1):examples);
    testing_targets = y2(:,(boundary + 1):examples);
    
    predictions = sim(network, testing_examples);
    f = mean(f1(NNout2labels(predictions), NNout2labels(testing_targets)));
end

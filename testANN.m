function [ predictions ] = testANN( net, x2 )
    predictions = NNout2labels(sim(net, x2));
end


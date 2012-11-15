function [ best_topology ] = testtop( examples, targets )

max_neurons = 50;

best_f1_avg = 0;

for i = 10:50
    for j = 0:50
        topology = [i, j];
        topology(topology == 0) = [];
        net = create_six_output( examples, targets, topology);
        net = train(net, examples, targets);
        preds = NNout2labels(sim(net,examples))
        f1_avg = mean(f1(preds, targets));
        if  f1_avg > best_f1_avg
            best_f1_avg = f1_avg;
            best_topology = topology;
        end
    end
end

end


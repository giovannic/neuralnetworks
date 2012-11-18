function [ ret, best_f1_avg, best_topology ] = testtop( examples, targets, targets_orig )

fid = fopen('topologytest.txt', 'w');
if fid == -1
    error('cant open file');
end
fprintf(fid, ' 1st    2nd   f1_avg \n');

test_targets = targets(:,1:673);
test_examples = examples(:,1:673);
validation_targets = targets_orig(674:1004);
validation_examples = examples(:,674:1004);
max_neurons = 50;

best_f1_avg = 0;

ret = zeros(2550, 3);
counter = 1;

for i = 1:max_neurons
    for j = 0:max_neurons
        topology = [i, j];
        topology(topology == 0) = [];
        net = create_six_output( test_examples, test_targets, topology);
        net = train(net, test_examples, test_targets);
        preds = NNout2labels(sim(net,validation_examples));
        f1_avg = mean(f1(preds, validation_targets));
        if  f1_avg > best_f1_avg
            best_f1_avg = f1_avg;
            best_topology = topology;
        end
        ret(counter, 1) = i;
        ret(counter, 2) = j;
        ret(counter, 3) = f1_avg;
        fprintf(fid, '%6.2f %6.2f %6.2f \n', i, j, f1_avg);
        counter = counter+1;
    end
    ret
end
fprintf(fid, 'best topology: %d with average f1 measure: %d', best_topology, best_f1_avg);
fclose(fid);

end


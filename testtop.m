function [ ret, best_f1_avg, best_topology ] = testtop( examples, targets, examples_orig, targets_orig )

fid = fopen('topologytest2.txt', 'w');
if fid == -1
    error('cant open file');
end
fprintf(fid, ' 1st    2nd   f1_avg   time_to_run\n');

test_targets = targets(:,1:673);
test_examples = examples(:,1:673);
targets_or = targets_orig(1:673,:);
examples_or = examples_orig(1:673,:);
%validation_targets = targets_orig(674:1004);
%validation_examples = examples(:,674:1004);
max_neurons = 30;

best_f1_avg = 0;

ret = zeros(2550, 3);
counter = 1;

for i = 1:max_neurons
    for j = 0:max_neurons
        topology = [i, j];
        topology(topology == 0) = [];
        totaltime = now;
        net = create_six_output(test_examples, test_targets, topology);
        preds = cross_validate(examples_or, targets_or, net);
        totaltime = now-totaltime;
        f1_avg = mean(f1(preds, targets_or));
        if  f1_avg > best_f1_avg
            best_f1_avg = f1_avg;
            best_topology = topology;
        end
        ret(counter, 1) = i;
        ret(counter, 2) = j;
        ret(counter, 3) = f1_avg;
        ret(counter, 4) = totaltime;
        fprintf(fid, '%6.2f %6.2f %6.2f %6.2f \n', i, j, f1_avg, totaltime);
        counter = counter+1;
    end
    ret
end
fprintf(fid, 'best topology: [%d, %d] with average f1 measure: %d', best_topology(1), best_topology(2), best_f1_avg);
fclose(fid);

end


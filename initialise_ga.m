function [GA_Networks] = initialise_ga(learning_rates, training_functions, transfer_functions, examples, targets, population_size)

if nargin < 6
	population_size = 100;
end

examples_len = length(examples);
boundary = ceil(0.6 * examples_len);

training_examples = examples(:,1:boundary);
training_targets = targets(:,1:boundary);

%% seed topology based on brute force testing of topologies.
best_topology = [13,27];

size_topology = 30;
size_training_functions = length(training_functions);
size_transfer_functions = length(transfer_functions);

for i = 1:population_size

  if i <= 0.1*population_size
    topology = best_topology;
  else
    topology = [randi(size_topology), randi(size_topology)];
  end
  params = [topology(1), topology(2), randi(size_transfer_functions), randi(size_transfer_functions), randi(size_transfer_functions), randi(size_training_functions), 100, learning_rates(randi(length(learning_rates))), learning_rates(randi(length(learning_rates)))];
  net = build_network(training_examples, training_targets, transfer_functions, training_functions, params);
  GA_Networks(i) = struct('network', net, 'parameters', params, 'fitness', 0);
i
end
end

function [networks] = initialise_ga(learning_rates, training_functions, transfer_functions, examples, targets, population_size)

if nargin < 6
	population_size = 100;
end

%topology = [13,27];

size_topology = 30;
size_training_functions = length(training_functions);
size_transfer_functions = length(transfer_functions);

for i = 1:population_size

  networks{i} = build_network( examples, targets, transfer_functions, training_functions, [randi(size_topology),randi(size_topology), randi(size_transfer_functions), randi(size_transfer_functions), randi(size_transfer_functions), randi(size_training_functions), 100, learning_rates(randi(length(learning_rates))), learning_rates(randi(length(learning_rates)))]);
i
end

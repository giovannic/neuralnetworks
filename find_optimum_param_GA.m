function [network, mf] = find_optimum_params_GA(population, threshold, r, m, x2, y2, transfer_functions, training_functions)
fid = fopen( 'best_network.dat', 'w' );
mf = 0;
pop_fitness = 0;
pop_length = length(population);
probabilities = zeros(pop_length, 1);
for i = 1:pop_length
  f = fitness_ga(x2, y2, population(i).network);
  population(i).fitness = f;
  pop_fitness = pop_fitness + f;
  if f > mf
    mf = f;
    network = population(i);
  end
end
generation = 1

while mf < threshold && generation < 100
%create new generation

  %SELECT
  for i = 1:pop_length
    probabilities(i) = population(i).fitness/pop_fitness;
  end
  cumprob = cumsum(probabilities) ./ sum(probabilities);
  selected = zeros(ceil((1-r)*pop_length));
  for added = 1:ceil((1-r)*pop_length)
    s = find(cumprob >= rand(1), 1);
    while any(selected==s)
      s = find(cumprob >= rand(1), 1);
    end
    selected(added) = s;

    boundary = ceil(0.66 * length(x2));
    training_examples = x2(:,1:boundary);
    training_targets = y2(:,1:boundary);
    params = population(s).parameters;
    net = build_network(training_examples, training_targets, transfer_functions, training_functions, params);
    p = struct('network', net, 'parameters', params, 'fitness', 0);
    population_next_gen(added) = p;
%    end_of_select_i = added
  end

  %CROSSOVER
  for i = 1:ceil(r*pop_length/2)
    h1 = find(cumprob >= rand(1),1);
    h2 = find(cumprob >= rand(1),1);
    [p1, p2] = crossover(population(h1),population(h2),x2,y2,transfer_functions,training_functions);
    population_next_gen(i+added) = p1;
    population_next_gen(pop_length-i+1) = p2;
%    end_of_crossover_i = i
  end

  %UPDATE
  population = population_next_gen;
  pop_fitness = 0;

  for i = 1:pop_length
%    member_of_population = i
    f = fitness_ga(x2, y2, population(i).network);
    population(i).fitness = f;
    pop_fitness = pop_fitness + f;
    if f > mf
      mf = f;
      network = population(i);
    end
  end
  params = network.parameters;
  fprintf(fid, 'best network:\n[');
  for j = 1:length(params)
    fprintf(fid, '%6.2f, ', params(j));
  end
  fprintf(fid, ']\n');
  ff=network.fitness;
  fprintf(fid, 'fitness value: %6.2f\n\n', ff );
  network
  mf
  generation = generation + 1
end
fclose(fid);
end



function [p1, p2] = crossover(h1, h2, examples, targets, transfer_functions, training_functions)
  params1 = h1.parameters;
  params2 = h2.parameters;
  for i = 1:length(params1)
    if rand(1) < 0.5
      params1(i) = h2(1).parameters(i);
      params2(i) = h1(1).parameters(i);      
    end
  end

  boundary = ceil(0.66 * length(examples));
  training_examples = examples(:,1:boundary);
  training_targets = targets(:,1:boundary);
  net = build_network(training_examples, training_targets, transfer_functions, training_functions, params1);
  p1 = struct('network', net, 'parameters', params1, 'fitness', 0);
  net = build_network(training_examples, training_targets, transfer_functions, training_functions, params2);
  p2 = struct('network', net, 'parameters', params2, 'fitness', 0);
end

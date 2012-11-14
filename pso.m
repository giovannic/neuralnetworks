function [ position ] = pso(boundary, examples, targets)
    train_ex = examples(1:boundary, :);
    train_targ = targets(1:boundary);
    test_ex = examples((boundary + 1):size(examples),:);
    test_targ = targets((boundary + 1):length(targets));
    
    max_neurons = 100;
    max_levels = 2;
    candidates = 5;
    default = [1,1];
    global_bestP = default;
    global_bestF = 0;
    
    candidate.position = default;
    candidate.velocity = default;
    candidate.bestP = default;
    candidate.bestF = 0;
    
    global_pull_rate = 2;
    local_pull_rate = 2;
    
    %initialise candidates
    for c = 1:candidates
        candidate(c).position = [randi(max_neurons,1), 1, max_levels];
        candidate(c).velocity = [randi(2*max_neurons,1) - max_neurons, 1, max_levels];
    end
    
    terminate = 0;
    rounds = 0;
    
    while(~terminate)
        
        for c = 1:candidates
            net = build_network(train_ex, train_targ, candidate(c).position)
            fitness = f1(sim(net, test_ex), test_targ)
            if candidate.bestF <= fitness
                candidate.bestF = fitness;
                candidate.bestP = candidate.position;
                if global_bestF <= fitness
                    global_bestF = fitness;
                    global_bestP = candidate.position;
                end
            end
        end
       
        error = 0;
        for c = 1:candidates
            %new velocoties and positions
            local_pull = local_pull_rate * (randi(2,1)-1) * (candidate.bestP - candidate.position);
            global_pull = global_pull_rate * (randi(2,1)-1) * (global_bestP - candidate.position);
            candidate.velocity = candidate.velocity + local_pull + global_pull;
            candidate.position = candidate.position + candidate.velocity;
            error = error + (global_bestP - candidate.position);
        end
        
        if (error < 5 || rounds > 100)
            terminate = 1;
        end
        
        rounds = rounds + 1;
        
    end
    
end
function [ net ] = build_network(train_ex, train_targ, dim)
    net = feedforwardnet(dim); 
    net = configure(net, train_ex, train_targ);
    net = train(net, train_ex, train_targ);
end
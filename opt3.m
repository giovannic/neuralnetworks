%Load in the data to x, y x = examples, y = outcomes
load cleandata_students.mat;
%put through ANNdata transforms data 
[x2, y2] = ANNdata(x, y);

f = @(a,b,v)(@(v)(fitness(a,b,v)));
genetic_fitness = f(x2,y2);

% params [1,2] = topology, [3,4,5] = transfer fn1,2,3, 6 = training fn, 7 = max epochs, 8 = learning rate, 9 = momentum

lower_bounds = [5,0,1,1,1,1,0,0.0001,0.0001];
upper_bounds = [30,17,3,3,3,11,100,0.5,0.5];
intc = [1,2,3,4,5,6,7];
options = gaoptimset(@ga);
options.FitnessLimit = 3;
options.PopulationSize = 100;
options.UseParallel = 'always';
options.Generations = 30;

[x, fval, exitflag, output] = ga(genetic_fitness,9,[],[],[],[],lower_bounds, upper_bounds,[], intc);

fid = fopen('opt2.out', 'w');

fprintf(fid,'x = %d\n', y);
fprintf(fid,'fval = %d \n', fval);

fclose(fid);

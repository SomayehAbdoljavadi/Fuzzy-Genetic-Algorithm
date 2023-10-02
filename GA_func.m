function [ popu age] = GA_func( TRule,inp,out)
generation_n = 20;	% Number of generations
%popuSize = 20;		% Population size
xover_rate = 0.05;	% Crossover rate
mutate_rate = 0.002;	% Mutation rate
age=zeros(50,1);

% Initial random population
popu = TRule; 

upper = zeros(generation_n, 1);
average = zeros(generation_n, 1);
lower = zeros(generation_n, 1);

% Main loop of GA
for i = 1:generation_n;

	% delete unnecessary objects
	delete(findobj(0, 'tag', 'member'));
	delete(findobj(0, 'tag', 'individual'));
	delete(findobj(0, 'tag', 'count'));

	% Evaluate objective function for each individual
	Tfcn_value=fcn_val(popu,inp,out);
    fcn_value=Tfcn_value(:,1).*Tfcn_value(:,2)+age;
    Tpopu=[popu fcn_value];
	% Fill objective function matrices
    T=Tpopu(Tpopu(:,1)==1,:);
    upper(i) = max(T(:,3));
	average(i) = mean(T(:,3));
	lower(i) = min(T(:,3));

	% generate next population via selection, crossover and mutation
	[popu age] = nextpopR(Tpopu,age,xover_rate, mutate_rate);

end

figure;
blackbg;
x = (1:generation_n)';
plot(x, upper, 'o', x, average, 'x', x, lower, '*');
hold on;
plot(x, [upper average lower]);
hold off;
legend('Best', 'Average', 'Poorest');
xlabel('Generations=50 population-Size=20 Elitism-Rate=40'); ylabel('Fitness');

function [new_popu age]= nextpopR(Tpopu,age, xover_rate, mut_rate)

new_popu = Tpopu(:,1:2);
popu_s = size(Tpopu, 1);

% ====== ELITISM: find the best two and keep them
index=zeros(3,3);
for i=1:3
    T=Tpopu(Tpopu(:,1)==i,:);
    [s In]=max(T(:,3));
    index(i,:)=T(In,:);
end

for o=1:50
   if Tpopu(o,:)==index(1,:)
       age(o)=age(o)+(10^(-4));
     %  break;
   end
   if Tpopu(o,:)==index(2,:)
       age(o)=age(o)+(10^(-4));
     %  break;
   end
   if Tpopu(o,:)==index(3,:)
       age(o)=age(o)+(10^(-4));
    %   break;
   end
end
new_popu(1:3,:) = [index(1,1:2); index(2,1:2) ;index(3,1:2)];

% =======rescaling the fitness===========
fitness = Tpopu(:,3) - min(Tpopu(:,3));	% keep it positive
total = sum(fitness);
if total == 0,
	fprintf('=== Warning: converge to a single point ===\n');
	fitness = ones(popu_s, 1)/popu_s;	% sum is 1
else
	fitness = fitness/sum(fitness);		% sum is 1
end
cum_prob = cumsum(fitness);

% ====== SELECTION and CROSSOVER
for p = 2:popu_s/2,
	% === Select two parents based on their scaled fitness values
	tmp = find(cum_prob - rand > 0);
	parent1 = Tpopu(tmp(1), 1:2);
	tmp = find(cum_prob - rand > 0);
	parent2 = Tpopu(tmp(1), 1:2);
	% === Do crossover
	if rand < xover_rate,
		% Perform crossover operation
        xover_point = rand;
		if xover_point<=0.5
            new_popu(p*2-1,1)=parent2(1);
		    new_popu(p*2, 1)=parent1(1);
        else
            new_popu(p*2-1,2)=parent2(2);
		    new_popu(p*2, 2)=parent1(2);  
        end
	end
end

% ====== MUTATION (elites are not subject to this.)
rand_mut=rand;
if rand_mut  < mut_rate;
    mut_point = rand;
    mut_num=round(rand_mut*49)+1;
		if mut_point<=.5
            new_popu(mut_num,1)=round(2*rand)+1;
           % new_popu(mut_num,3) = gauss_mf(x(i), ante_param(j,:));
        else
           new_popu(mut_num,2)=round(2*rand)+1;
        end
    
end

% restore the elites
new_popu(1:3,:) = [index(1,1:2); index(2,1:2) ;index(3,1:2)];


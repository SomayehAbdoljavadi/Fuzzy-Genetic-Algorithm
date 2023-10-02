clc
clear all
close all

point_n = 50;
Ant_num=3;
Cons_num=3;
x = linspace(0, pi, point_n);
y=2*cos(2*x);
%plot(x,y);
ante_param = [0           pi/8;
              %pi/6        pi/16;
             % pi/4        pi/16;
              pi/2        pi/8;
              pi          pi/8] ;
ante_mf = zeros(Ant_num, point_n);
for i=1:Ant_num
    ante_mf(i, :) = gauss_mf(x, ante_param(i, :));
end
figure;
subplot(211);
plot(x', ante_mf');
axis([-inf inf 0 1.2]);
xlabel('X'); ylabel('Membership Grades');
text(.5, 1.1, 'small');
text(1.5, 1.1, 'medium');
text(2.5, 1.1, 'large');

%y = linspace(0, 10, point_n);
cons_param = [-2   1/2;
               0   1/2;
             
               2   1/2];

cons_mf = zeros(Cons_num, point_n);
for i=1:Cons_num
    cons_mf(i, :) = gauss_mf(y, cons_param(i, :));
end



subplot(212);
plot(y', cons_mf');

axis([-inf inf 0 1.2]);
xlabel('Y'); ylabel('Membership Grades');
text(-1, 1.1, 'small');
text(0, 1.1, 'medium');
text(1, 1.1, 'large');

set(findobj(gcf, 'type', 'text'), 'hori', 'center');

output = zeros(size(x));
%qualified_cons_mf = zeros(Cons_num, point_n);
for i = 1:point_n,
    for j=1:Ant_num
        	w(j) = gauss_mf(x(i), ante_param(j,:));
    end
    for j=1:Cons_num
	        v(j) = gauss_mf(y(i), cons_param(j,:));
    end
	[W(i) In_ant(i)]=max(w);
    [V(i) In_cons(i)]=max(v);
       
end

%TRule(:,3)=W.*V;
TRule(:,1)=In_ant;
TRule(:,2)=In_cons;
[Rule age]=GA_func(TRule,x,y);
mf=fcn_val(Rule,x,y);
Rule(:,3)=mf(1).*mf(2)+age;
%Rule=sortrows(Rule,-1);
En_Rule=Rule_func(Rule,3);
Test(point_n,y,En_Rule,Ant_num,ante_param,cons_mf);














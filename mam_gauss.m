clear all
close all
%genfig('Single-input Mamdani fuzzy model: MFs');

point_n = 300;
Ant_num=7;
Cons_num=3;
%x = linspace(0, pi, point_n);
a = 0 ;  b= pi  ;
x= b*rand(1,point_n);
x=sort(x);
y=2*cos(4*x);
scatter(x,y);
y1=sort(y);
ante_param = [0           pi/16;
              pi/6        pi/16;
              pi/3        pi/16;
              pi/2        pi/16;
              2*pi/3      pi/16;
              5*pi/6      pi/16;
              pi          pi/16] ;
grid on 		       

%figure;
grid off
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
            %  -1   1/6;
               0   1/2;
             %  1   1/6;
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

TRule(:,3)=W.*V;
TRule(:,1)=In_ant;
TRule(:,2)=In_cons;
Rule=Rule_func(TRule,Ant_num);

for i=1:point_n
    Xindex=find(Rule(:,1)==In_ant(i));
    output(i)=defuzzy(y(i),cons_mf(Rule(Xindex,2),:),1);
    
end

%genfig('Single-input Mamdani fuzzy model: input-output curve');
hold on,
scatter(x,y);
scatter(x, output,'r+');
%hold off
axis([min(x) max(x) min(y) max(y)]);
xlabel('X'); ylabel('Y');
%Rules Extraction

















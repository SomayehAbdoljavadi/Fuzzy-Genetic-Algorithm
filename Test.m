function [ ] = Test(point_n,y,Rule,Ant_num,ante_param,cons_mf )
a = 0 ;  b= pi  ;
x= b*rand(1,point_n);
x=sort(x);
y1=2*cos(2*x);
%x=0:(pi)/49:pi;
%scatter(x,y1);


ante_mf = zeros(Ant_num, point_n);
for i=1:Ant_num
    ante_mf(i, :) = gauss_mf(x, ante_param(i, :));
end
%y = linspace(0, 10, point_n);
output = zeros(size(x));
%qualified_cons_mf = zeros(Cons_num, point_n);
for i = 1:point_n,
    for j=1:Ant_num
        	w(j) = gauss_mf(x(i), ante_param(j,:));
    end
    for j=1:Ant_num
        
        qualified_cons_mf(j, :) = min(w(Rule(j,1)), cons_mf(Rule(j,2), :));
    end
    overall_out_mf = max(qualified_cons_mf);
	output(i) = defuzzy(y, overall_out_mf,1); 
end
z=(sum((y1-output).^2))/point_n
%figure
genfig('Single-input Mamdani fuzzy model: input-output curve');
hold on,
%scatter(x,y1);
scatter(x, output,'r+');
plot(x,y1,'b')
%plot(x,output,'r')

hold off
axis([min(x) max(x) min(y) max(y)]);
xlabel('Test is scotter ,square error'); ylabel('Y');
%Rules Extraction

end















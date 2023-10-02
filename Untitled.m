
a = 0; b = 180;
x = a + (b-a) * rand(1,50);
x=(pi*x)/180;
%x=sort(x);
y=cos(4*x);
scatter(x,y);
xlabel('X');
ylabel('Y');
title('cos(4*t)');

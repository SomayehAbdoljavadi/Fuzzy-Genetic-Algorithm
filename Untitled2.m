minimumx=0;maximumx=3.5;
stepx=0.1;
x1=0:0.2:0.5;
x2=0.5:0.05:1;
x3=1:0.2:2.5;
x4=2.5:0.05:3;
x5=3:0.2:3.5;
 
xall=zeros(1,length(x1)+length(x2)+length(x3)+length(x4)+length(x5)-4);
xall(1,1:length(x1))=x1;   xall(1,length(x1):length(x1)+length(x2)-1)=x2;   xall(1,length(x1)+length(x2)-1:length(x1)+length(x2)+length(x3)-2)=x3;
xall(1,length(x1)+length(x2)+length(x3)-2:length(x1)+length(x2)+length(x3)+length(x4)-3)=x4;
xall(1,length(x1)+length(x2)+length(x3)+length(x4)-3:length(x1)+length(x2)+length(x3)+length(x4)+length(x5)-4)=x5;
x1=xall;
centersetx=zeros(size(x1,2),3);
centersetx(1,1:3)=[x1(1),x1(1),x1(2)];
for i=2:length(x1)-1
    centersetx(i,:)=[centersetx(i-1,2),x1(i),x1(i+1)];
end
centersetx(length(x1),:)=[centersetx(length(x1)-1,2),maximumx,maximumx];
x1=0:0.01:3.5;
xexit=zeros(length(centersetx),length(x1));
xexit(1,:)=tri_mf(x1,centersetx(1,:));
for i=1:length(centersetx)
xexit(i,:)=tri_mf(x1,centersetx(i,:));
end
figure;
plot(x1,xexit(1,:));
hold all
for i=1:size(xexit,1)
plot(x1,xexit(i,:));
end
hold off
xlabel('X');
ylabel('Degree of membership');

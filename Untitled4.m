% __________________(3-a)______________________
 
a = 0; b = 180;
x = a + (b-a) * rand(1,50);
x=(pi*x)/180;
%x=sort(x);
y=cos(4*x);
scatter(x,y,'r *');

xlabel('X');
ylabel('Y');
title('2cos(2*t)');
hold on;
% __________________(3-b)______________________
 
% Partitioning of input and output spaces into appropriate number of membership functions
 
% ---------------- partitioning of input space----------------

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
%hold off
xlabel('X');
ylabel('Degree of membership');
% ---------------- partitioning of output space----------------

minimumy=-15;maximumy=15;
y1=-2:0.2:-1;
y2=-1:0.1:1;
y3=1:0.2:2;
yall=zeros(1,length(y1)+length(y2)+length(y3)-2);
yall(1,1:length(y1))=y1;   yall(1,length(y1):length(y1)+length(y2)-1)=y2;   yall(1,length(y1)+length(y2)-1:length(y1)+length(y2)+length(y3)-2)=y3;
 
centersety=zeros(length(yall),3);
centersety(1,1:3)=[yall(1),yall(1),yall(2)];
for i=2:length(yall)-1
   centersety(i,:)=[centersety(i-1,2),yall(i),yall(i+1)];
end
centersety(length(yall),:)=[centersety(length(yall)-1,2),maximumy,maximumy];
 
yexit=zeros(length(centersety),length(yall));
for i=1:length(centersety)
yexit(i,:)=tri_mf(yall,centersety(i,:));
end
 
figure;
plot(yall,yexit(1,:));
hold all
for i=2:size(yexit,1)
plot(yall,yexit(i,:));
end
%hold off
xlabel('Y');
ylabel('Degree of membership');
 
% __________________(3-c)______________________
% **************** calculate value of each mf for each x(i) *******************
 
for i=1:size(x,2)
    num=0;
    for j=1:size(centersetx,1)
        if x(i)>centersetx(j,1)&& x(i)<centersetx(j,3)
            num=num+1;
            valuemfx(i,num)=tri_mf(x(i),centersetx(j,:));
            indexmfx(i,num)=j;
        end
    end
end
 
 
% **************** calculate value of each mf for each y(i) *******************
 
for i=1:size(y,2)
    num=0;
    for j=1:size(centersety,1)
        if y(i)>centersety(j,1)&& y(i)<centersety(j,3)
            num=num+1;
            valuemfy(i,num)=tri_mf(y(i),centersety(j,:));
            indexmfy(i,num)=j;
        end
    end
end
 
 
% ************** finding all rules *****************
 
ruleh(1,1)=indexmfx(1,1);
ruleh(2,1)=indexmfy(1,1);
index=2;
num=1;
for i=2:size(indexmfx,1)
    if indexmfx(i,1)==ruleh(1,index-1)
        ruleh(1,index)=indexmfx(i,1);
        ruleh(2,index)=indexmfy(i,1);
        num=num+1;
        index=index+1;
    else
    ruleh(1,index:index+num-1)=indexmfx(i-num:i-1,2);
    ruleh(2,index:index+num-1)=indexmfy(i-num:i-1,2);
    index=index+num;
    ruleh(1,index)=indexmfx(i,1);
    ruleh(2,index)=indexmfy(i,1);
    index=index+1;
    num=1;
    end
end
ruleh(1,index:index+num-1)=indexmfx(i-num+1:i,2);
ruleh(2,index:index+num-1)=indexmfy(i-num+1:i,2);
 
% ************** calculate number of iteration for each of rules ********************
index=1;
num=1;
ruleh2(2,index)=ruleh(2,1);
ruleh2(1,index)=ruleh(1,1);
for i=2:size(ruleh,2)
     if(ruleh(1,i-1)==ruleh(1,i))
        if(ruleh(2,i-1)~=ruleh(2,i))
            index=index+1;
            num=1;
            ruleh2(2,index)=ruleh(2,i);
            ruleh2(1,index)=ruleh(1,i);
            ruleh2(3,index)=num;
        else
            num=num+1;
            ruleh2(3,index)=num;
        end
     else
          index=index+1;
          num=1;
            ruleh2(2,index)=ruleh(2,i);
            ruleh2(1,index)=ruleh(1,i);
            ruleh2(3,index)=num;
     end
end
% ************** finding rule that have maximum iteration rather than other same rules ********************
index=1;
rule(1,1)=indexmfx(1,1);
rule(2:3,1)=indexmfy(1,1);
for i=2:size(ruleh2,2)
    if (ruleh2(1,i)==rule(1,index))
        if(ruleh2(3,i)>rule(3,index))
        rule(:,index)=ruleh2(:,i);
        end
    else
        index=index+1;
        rule(:,index)=ruleh2(:,i);
    end
end


 % __________________(3-d)______________________
% ***************calculate y from fuzzy system ***************

for i=1:size(valuemfx,1)
    index1=1;
    index2=1;
    while rule(1,index1)~=indexmfx(i,1)
        index1=index1+1;
    end
    while rule(1,index2)~=indexmfx(i,2)
        index2=index2+1;
    end
    mfb1=yexit(rule(2,index1),:);
    mfb2=yexit(rule(2,index2),:);
    mfa1=tri_mf(x(i),centersetx(indexmfx(i,1),:));
    mfa2=tri_mf(x(i),centersetx(indexmfx(i,2),:));
    mfbprim1=mfa1.*mfb1;
    mfbprim2=mfa2.*mfb2;
    [w1 y1]=max(mfbprim1);
    [w2 y2]=max(mfbprim2);
    y1=yall(y1);
    y2=yall(y2);
% clculated value of y with singelton fuzzifier and center average defuzzifer is: 
    ystar(1,i)=((w1*y1)+(w2.*y2))/(w1+w2);
end
 
figure;
% subplot(3,2,1)
%scatter(x,y,'r');
hold all
scatter(x,ystar,'b +'); figure(gcf)
%hold off
xlabel('X');
ylabel('Y');
title('cos(4*X)');
ystar

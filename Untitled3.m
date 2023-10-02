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
hold off
xlabel('Y');
ylabel('Degree of membership');

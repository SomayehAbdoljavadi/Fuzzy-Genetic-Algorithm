function [ Rule ] = Rule_func( TRule,ant_num )
for i=1:ant_num
    T=TRule(TRule(:,1)==i,:);
    [s In]=max(T(:,3));
    Rule(i,:)=T(In,:);
end


%temp2_index=find(temp_index>2);
%     Rule(2,:)=max(TRule(temp1_index(1):temp2_index(1)-1,:));
%     Rule(3,:)=max(TRule(temp2_index(1):size(TRule,1),:));
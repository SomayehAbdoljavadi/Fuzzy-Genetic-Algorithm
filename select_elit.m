function [fcn_val elit ] = select_elit(popu,fcn_value,elit_n)
[x y]=size(popu);
fcn_val=zeros(x,y+1);
   fcn_val(:,1:y)=popu;
   fcn_val(1:x,y+1)=fcn_value;
   fcn_val=sortrows(fcn_val,-(y+1));
   elit=(fcn_val(1:elit_n,1:y));

end


function [ fcn_value ] = fcn_val( popu,x,y)

fcn_value(:,1)= gauss_mf(x(:), popu(:,1));
fcn_value(:,2)= gauss_mf(y(:), popu(:,2));


end


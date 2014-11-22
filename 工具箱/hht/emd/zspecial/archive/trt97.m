function [zz,tt]=trt97(t,x)
%
% [zz,tt]=trt97(t,x): 
% Function to cut off the bad points of the current metre data.
% Input-
%	t	- vector representing the date of each value (in hours)
%	x	- vector representing the metre data
% Output-
%	tt	- vector representing the date of each value (in hours)
%		with some points cut off
%	zz	- vector representing the metre data
%		with some points cut off
%
% Z. Shen (Caltech)	June 1997 Initial
%
% Notes-
% Use spline to fit the output.
% Before this program, use 'getdt97.m'.

n=length(x);
tt=-999;
zz=-999;
for i=1:n
   if(x(i)<30)
      tt=[tt t(i)];
      zz=[zz x(i)];
   end
end
tt=tt';
zz=zz';
m=length(zz);
tt=tt(2:m);
zz=zz(2:m);
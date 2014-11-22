function t=getdt97(x)
%
% t=getdt97(x):
% Function to get a date (in hours) using 1995 January as 0 point.
%
% Input-
%	x- matrix x(n,4) representing the date for each value, where
%		 x(:,1) is the year (YY), x(:,2) is the month (MM),
%		 x(:,3) is the day (DD), x(:,3) is the hour (HH)
% Output-
%	t- vector representing the date (in hours) for each value
%
% Note-
% Example: x=[95,1,0,1]; t=getdt97(x); t returned is 0.  


n=size(x);
n=n(1,1);

t=zeros(n,1);

for i=1:n,
   n1=datenum(1900+x(i,1),x(i,2),x(i,3))-datenum(1995,1,0)-1;
   n2=x(i,4);
   m=n1*24+n2+1;
   t(i)=m;
end

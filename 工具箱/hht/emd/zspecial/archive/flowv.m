function [X,Y,Px,Py]=flowv(dg,ta,ra,r,n)
%
% [X,Y,Px,Py]=flowv(dg,ta,ra,r,n):
%
% Function to prepare the propeler polar velocity data for 
% using quiver1(x,y,px,py) to plot the velocity field.
% Input-
%	dg,ta,ra	- vectors
%	r		    - the radius
%	n		    - divided number
% Output-
%	X		    - x coordinates
%	Y		    - y coordinates
%	Px		    - values in cart coordinates
%	Py		    - values in cart coordinates

m=max(size(dg));
m1=m/n;

dg1=zeros(m1,1);
ta1=dg1;
ra1=dg1;

for i=1:m1,
   dg1(i)=dg(n*(i-1)+1);
   ta1(i)=ta(n*(i-1)+1);
   ra1(i)=ra(n*(i-1)+1);
%   for j=1:n,   
%      ta1(i)=ta1(i)+ta((i-1)*n+j);
%      ra1(i)=ra1(i)+ra((i-1)*n+j);
%   end
end
clear dg ta ra;
%ta1=ta1/n;
%ra1=ra1/n;
dg1=dg1*2*pi/360;
x=r*cos(dg1);
y=r*sin(dg1);
[X,Y]=meshgrid(x,y);
px=-1*ta1.*sin(dg1)-ra1.*cos(dg1);
py=ta1.*cos(dg1)-ra1.*sin(dg1);
Px=zeros(m1,m1);
Py=Px;
for i=1:m1,
   Px(i,i)=px(i);
   Py(i,i)=py(i);
end
i=find(Px==0 && Py==0);
X(i)=NaN*ones(size(i));
Y(i)=NaN*ones(size(i));

function [zx,zt]=zmap(x)
% [zx,zt]=zmap(z): Construct 1-D map from z(1:n);

%	Z. SHEN    May 1997
%  At Caltech


n=length(x);
zt=zeros(n-1,1);
zx=zeros(n-1,1);

for i=1:n-1
   zt(i)=x(i);
   zx(i)=x(i+1);
end

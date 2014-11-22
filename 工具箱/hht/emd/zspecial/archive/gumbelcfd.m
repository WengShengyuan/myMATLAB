function [w1,w2]=gumbelcfd(g,x,a,u)
%
% [w1,w2]=gumbelcfd(g,x,a,u):
% Function to perform a specific analysis on data.
%
% Input-
%	g,x	- vectors of n dimension
%	a,u	- values (a should not be equal zero)
% Output-
%	w1,w2	- vectors of n dimension
%

n=length(x);
n1=n-2;
z=u+x/a;
w1=zeros(n,1);
w2=zeros(n,1);

for i=1:n1,
   if(g(i)<.17)
      a1=2.51/a/sqrt(n);
      w1(i)=x(i)+a1;
      w2(i)=x(i)-a1;
   elseif(g(i)<.4)
      a1=2.54/a/sqrt(n);
      w1(i)=x(i)+a1;
      w2(i)=x(i)-a1;
   elseif(g(i)<.6)
      a1=2.89/a/sqrt(n);
      w1(i)=x(i)+a1;
      w2(i)=x(i)-a1;
   elseif(g(i)<.75)
      a1=3.67/a/sqrt(n);
      w1(i)=x(i)+a1;
      w2(i)=x(i)-a1;
   else
      a1=5.17/a/sqrt(n);
      w1(i)=x(i)+a1;
      w2(i)=x(i)-a1;
   end      
end
a1=1.51/a;
w1(n1+1)=x(n1+1)+a1;
w2(n1+1)=x(n1+1)-a1;
a1=2.28/a;
w1(n)=x(n)+a1;
w2(n)=x(n)-a1;
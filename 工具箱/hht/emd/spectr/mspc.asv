function ms=mspc(x,f)
 
% The function MSPC calculates a normalized marginal damping spectrum
% of x(k,n), where k specifies the number of frequencies, and 
% n is the number of time values.
%
% MSPC can be used after NSP, NSPAB.
% Function PLOT can be used to view the marginal spectrum,
%    for example, plot(f,ms).
%
% Calling sequence-
% ms=mspc(x,f)
%
% Input-
%	x	- 2-D matrix x(k,n) of the HHT spectrum
%	f	- vector f(k) that specifies the frequency-axis values
%
% Output-
%	ms	- vector ms(k) that specifies the marginal spectrum	
 
% Z. Shen (JHU)		March, 1996 Initial
% J. Marshak (NASA GSFC)	Feb.24, 2004 Modified
%				(removed frequency from being returned).

%----- Get dimensions
n=size(x);
k=n(1);
n=n(2);

%----- Calculate the average square sum
x=x.*x;
ms=sum(x')'/n;
plot(f,ms)

%f1=f;


%h=h.*h;
%dw=(w1-w0)/n;
%s=sum(h);
%h=h/(s*dw);

        
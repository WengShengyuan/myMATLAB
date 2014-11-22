function ms=hspc(x,tt)
%
%    ms=hspc(x,tt):
%    Function to calculate a normallized marginal spectrum of x(k,n),
%    where k specifies the number of periods, and 
%    n is the number of time values.
%
%    Input-
%	x	- 2-D matrix x(k,n) of the HHT spectrum
%	tt	- vector tt(k) that specifies the period-axis values
%
%    Output-
%	ms	- vector ms(k) that specifies the marginal spectrum		
%
%    Z. SHEN (JHU)		March, 1996 Initial
%    J. Marshak (NASA GSFC)	Jan. 28, 2004 Edited
%
%    Notes-
%    This program can be used after 'hspab.m'.
%    Function 'plot()' can be used to view the marginal spectrum,
%    for example, plot(tt,ms).
%
%    Temporary remarks-
%    Remove commented lines.
%    Why the averaged sum is called as a normalized marginal spectrum?
%    Rename and combine with 'mspc()'.

%----- Get dimensions
n=size(x);
k=n(1);
n=n(2);
;x=x.*x;

%----- Calculate the average sum
h=sum(x')'/n;
        
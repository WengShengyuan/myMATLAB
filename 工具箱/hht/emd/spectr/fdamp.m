function msf=fdump(x)

% The function FDUMP calculates a normalized marginal damping spectrum
% of x(k,n),where k specifies the number of frequencies, 
% and n is the number of time values.
%
% This code is used after NSPABD, which generates a damping spectrum.
% 
% Function PLOT can be used to view the marginal spectrum,
% for example, plot(length(msf),msf).
%
% Calling sequence-
% msf=fdump(x)
%
% Input-
%	x	- 2-D matrix x(k,n) of the HHT spectrum
%
% Output-
%	ms	- vector ms(k) that specifies the marginal spectrum
%
% Used by-
%	CALDSPEC, CALDSPECO	
 
% L. W. Salvino			Apr.23, 1998 Modified from 'mspc.m'

%----- Get dimensions
n=size(x);
k=n(1);
n=n(2);

%----- Calculate the normalized marginal damping spectrum
y=x.*x;
msf=sum(x')/n;
msf=sqrt(msf);





        
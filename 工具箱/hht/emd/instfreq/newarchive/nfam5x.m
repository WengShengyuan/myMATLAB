function [nf, na, ex, E, N] = nfam5x(data,dt)

% The function NFAM5X calculates the smoothed modified Hilbert frequency and amplitude
% of data(n,k), where n specifies the length of time series, 
% and k is the IMF component number.
% Except frequency and amplitude the function returns three other fields.
% Data is normalized with spline fitting of maxima using
% the function ENVLP, which extends both ends of data with
% two waves and then applies the cubic spline to find the envelope for
% maximum points.
% Final frequency and amplitude values are smoothed with a 5-point
% median filter.
% Modified Hilbert transform function HILBTM is used
% to perform a Hilbert transform.
%
% Non MATLAB Library routines used in the function are: ENVLP, HILBTM.
% Note: NFAM5X works only with one component.
%
% Calling sequence-
% [nf,na,ex,E,N]=nfam5x(data,dt)
%
% Input-
%	data	- 2-D matrix data(n,k) of one IMF component with
%		    2nd dimension being equal to 1
%	dt	    - sampling period in seconds
% Output-
%	nf	    - 2-D matrix nf(n,k) that specifies the Hilbert frequency in Hz
%	na	    - 2-D matrix nf(n,k) that specifies the Hilbert amplitude
%	ex	    - 2-D matrix nf(n,k) that specifies the splined envelope
%	E	    - 2-D matrix nf(n,k) that specifies the normalized input data
%	N	    - 2-D matrix N(n,k) that specifies the nonlinearity index
%
% See also-
%	NFAM5, 
%	which applies different envelope calculation technique.
 
% Norden Huang (NASA GSFC)	June 2, 2002 Initial

%----- Get dimensions
[n,m] = size(data); 
te=1:n; te=te';

%----- Invoke new end point treatment (by Dan 06/12/02)
%  which fixes the ends to prevent wide swaying in spline 
%  by assigning two extrema
[ex, emi]=envlp(data);  

%----- Normalize data by splined envelope
E=data./ex;

%----- Apply modified Hilbert transform
nf=diff(unwrap(angle(hilbtm(E))))./(2*pi*dt);
nf=[nf;nf(n-1)];
na=abs(hilbtm(E));

%----- Apply median for every 5 points, 5/4/02
for i=3:n-2
    nf(i,:)=median(nf(i-2:i+2,:));
    na(i,:)=median(na(i-2:i+2,:));
end
    
%----- Compute the Nonlinear Index
N=(na-1).^2;

%----- Re-constitute na
%  na=na.*ex;

%----- Plot the results
plot(te,data,te,ex,te,E,te,nf,te,na,te,N, 'LineWidth', 1.5);
legend('Data','ex','E','nf','na','N');

function [nf, na, ex, E, N] = nfam5(data,dt)
  
% The function NFAM5 calculates the smoothed modified Hilbert frequency and amplitude
% of data(n,k), where n specifies the length of time series,   
% and k is the IMF component number.
% Except frequency and amplitude the function returns other fields described below.
% Data is normalized with spline fitting of maxima with the ends fixed.
% Final frequency and amplitude values are smoothed with a 5-point
% median filter.
% Modified Hilbert transform function HILBTM is used
% to perform a Hilbert transform.
% 
% Non MATLAB Library routines used in the function are: EMAX, HILBTM.
% Note: NFAM5 works only for one IMF component.
%
%
% Calling sequence-
% [nf,na,ex,E,N]=nfam5(data,dt)
%
% Input-
%	data	- 2-D matrix data(n,k) of one IMF component with
%		    2nd dimension being equal to 1
%	dt	    - sampling period in seconds
% Output-
%	nf	    - 2-D matrix nf(n,k) that specifies the Hilbert frequency in Hz
%	na	    - 2-D matrix na(n,k) that specifies the Hilbert amplitude
%	ex	    - 2-D matrix ex(n,k) that specifies the splined envelope
%	E	    - 2-D matrix E(n,k) that specifies the normalized input data
%	N	    - 2-D matrix N(n,k) that specifies the nonlinearity index
 
% Norden Huang (NASA GSFC)	June 2, 2002 Initial
% Norden Huang (NASA GSFC)	November 1, 2002 Modified

%----- Get dimensions
[n,m] = size(data); 
te=1:n; te=te';

%----- Extract the set of max points and their coordinates
[mx, tx]=emax(data);

%----- Fix the ends to prevent wide swaying in spline 
%----- by adding the te(1) anf te(n) and mx(1) and mx(p) 
%----- to the first and last tx and mx
[p,q]=size(mx);
[u,v]=size(tx);
tx=[te(1);tx;te(n)];
mx=[mx(1);mx;mx(p)];
ex=spline(tx,mx,te);

%----- Normalize data by splined envelope
E=data./ex;

%----- Apply modified Hilbert transform
H=hilbtm(E);

nf=diff(unwrap(angle(H)))./(2*pi*dt);
nf=[nf;nf(n-1)];
na=abs(H);

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

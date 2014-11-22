function [nf, na, ex, E, N] = nfa(data,dt)
  
% The function NFA calculates the Hilbert frequency and amplitude
% of data(n,k), where n specifies the length of time series, and 
% k is the IMF component number.
% Except frequency and amplitude the function returns other fields.
% Data is normalized with spline fitting of maxima with the ends fixed.
% MATLAB library function HILBERT is used to perform a Hilbert transform.
% 
% Non MATLAB Library routine used in the function is: EMAX.
%
% Calling sequence-
% [nf,na,ex,E,N]=nfa(data,dt)
%
% Input-
%	data	- 2-D matrix data(n,k) of one IMF component with
%		    2nd dimension being equal to 1
%	dt	    - sampling period in seconds
% Output-
%	nf	- 2-D matrix nf(n,k) that specifies the Hilbert frequency in Hz
%	na	- 2-D matrix na(n,k) that specifies the Hilbert amplitude
%	ex	- 2-D matrix ex(n,k) that specifies the splined envelope
%	E	- 2-D matrix E(n,k) that specifies the normalized input data
%	N	- 2-D matrix N(n,k) that specifies the nonlinearity index
 
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

%----- Apply MATLAB Hilbert transform
H=hilbert(E);

nf=diff(unwrap(angle(H)))./(2*pi*dt);
nf=[nf;nf(n-1)];
na=abs(H);
    
%----- Compute the Nonlinear Index
N=(na-1).^2;

%----- Re-constitute na
%  na=na.*ex;

%----- Plot the results
plot(te,data,te,ex,te,E,te,nf,te,na,te,N, 'LineWidth', 1.5);
legend('Data','ex','E','nf','na','N');

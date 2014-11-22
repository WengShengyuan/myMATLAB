function [nhf, nha, hex, hE, hN] = nhfam(data,dt)
  
% The function NHFAM calculates the modified Hilbert frequency and amplitude
% of data(n,k), where n specifies the length of time series, and 
% k is the IMF component number.
% Except frequency and amplitude the function returns other fields.
% Data is normalized with modified Hilbert transformed envelope.
% Final frequency and amplitude values are not smoothed with any filter.
% Modified Hilbert transform function HILBTM is used 
% to perform a Hilbert transform.
%
% Non MATLAB Library routine used in the function is: HILBTM.
% Note: works only for one IMF component.
%
% Calling sequence-
% [nhf,nha,hex,hE,hN]=nhfam(data,dt)
%
% Input-
%	data	- 2-D matrix data(n,k) of one IMF component, with
%		    2nd dimension being equal to 1
%	dt	    - sampling period in seconds
% Output-
%	nhf	    - 2-D matrix nhf(n,k) that specifies the Hilbert frequency in Hz
%	nha	    - 2-D matrix nha(n,k) that specifies the Hilbert amplitude of
%		    normalized data
%	hex	    - 2-D matrix hex(n,k) that specifies the Hilbert envelope data
%	hE	    - 2-D matrix hE(n,k) that specifies the normalized data
%	hN	    - 2-D matrix hN(n,k) that specifies the nonlinearity index
 
% Norden Huang (NASA GSFC)	June 2, 2002 Initial
% Norden Huang (NASA GSFC)	November 1, 2002 Modified

%----- Get dimensions
[n,m] = size(data); 
te=1:n; te=te';

%----- Apply modified Hilbert transform to get an envelope
hex=abs(hilbtm(data));

%----- Normalize the data by Hilbert envelope
hE=data./hex;

%----- Apply modified Hilbert transform
H=hilbtm(hE);

nhf=diff(unwrap(angle(H)))./(2*pi*dt);
nhf=[nhf;nhf(n-1)];
nha=abs(H);
    
%----- Compute the Nonlinear Index
hN=(nha-1).^2;

%----- Re-constitute na
%  na=na.*hex;

%----- Plot the results
plot(te,data,te,hex,te,hE,te,nhf,te,nha,te,hN, 'LineWidth', 1.5);
legend('Data','hex','hE','nhf','nha','hN');
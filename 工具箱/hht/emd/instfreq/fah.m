function [hf, ha] = fah(data,dt)

% The function FAH calculates an improved Hilbert frequency and amplitude
% of data(n,k), where n specifies the length of time series, and 
% k is the number of IMF components.
% Improved Hilbert transform function HILBT
% is used to perform a Hilbert transform.
%
% Non MATLAB Library routine used in the function is: HILBTM.
% Note: FAH allows the instantaneous frequency to be negative. 
%
% Calling sequence-
% [hf,ha] = fah(data,dt)
%
% Input-
%   data	- 2-D matrix data(n,k) of IMF components 
%	dt	    - sampling period in seconds
% Output-
%	hf	    - 2-D matrix hf(n,k) that specifies the Hilbert frequency in Hz
%	ha	    - 2-D matrix ha(n,k) that specifies the Hilbert amplitude
%
% Used by-
% 	FA, NSPABEH.

%----- Get the dimension
[n,m] = size(data);            

%----- Apply improved Hilbert transform
h=hilbtm(data);

%----- Get the instantaneous frequency
hf=diff(unwrap(angle(h)))./(2*pi*dt);

%----- Duplicate last points to make dimensions equal
hf=[hf;hf(n-1,:)];

%----- Get the amplitude
ha=abs(h);

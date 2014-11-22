function [aeq,f_n] = shock(time, acc, f, zeta)

% The function SHOCK computes the shock spectrum for a damped oscillator.
%  
% To Compare with the power spectrum from Fourier Transform
%		[p, w] = [fn, (aeq./fn).^2]
%
% MATLAB prompt:  [aeq,fn] = shock(time, acc, f, zeta);
%	     or:   aeq = shock(time, acc, f, zeta);
%
% Calling sequence-
% [aeq,f_n] = shock(time, acc, f, zeta)
%
% Input-
%	time	- vector containing the times (in sec)
%		    at which the base acceleration has been measured;
%		    it should have the same length and number of
%		    as the 'acc' data. Make a vector 'time'.	
%	acc	    - vector containing base acceleration
%	f	    - f=[fmin fmax ftotal] vector containing the natural
%		    frequencies of the attached oscillator (Hz)
%	zeta	- damping of attached oscillator
%
% Output-
%	aeq	    - acceleration spectrum aeq=freq.^2.*max(delta)
%		    delta is the relative displacement between base 
%		    and spring mass
%	f_n	    - vector of values

% L. W. Salvino		Dec. 3. 1997 Modified, tested and verified
 
% Time changes along columns and natural frequency along rows
%
tic
cc=log10(f(2)./f(1))./f(3);
f_n=f(1).*10.^((0:1:(f(3)-1))'.*cc);
f_n=[f_n(1:(length(f_n)-1)); f(2)];
w_n=2.*pi.*f_n;
%
if(size(time,2) ~= 1) 
 time = time.';
end
if(size(acc,2) ~= 1) 
 acc = acc.';
end
if(size(w_n,1) ~=1)
 w_n = w_n.';
end
%
n_rows = size(time,1);
n_cols = size(w_n,2); 
%
% Compute vector of time steps
%
df = diff(time);
L  = length(df);
%dt = (1/2)*[df(1); df(1:(L-1))+df(2:L); df(L)];
dt = (1/2)*[2.*df(1); df(1:(L-1))+df(2:L); 0];
% Make everything matrices (capital letters denote matrices)
%
TIME  = time*ones(1,n_cols);
DT    = dt*ones(1,n_cols);
ACC   = acc*ones(1,n_cols);
%
W_N = ones(n_rows,1)*w_n;
W_D = W_N*sqrt(1-zeta^2);
%
% Compute shock spectrum by trapezoidal rule integrations along columns
%
% Reference: Shock and Vibration Handbook (3rd Edition), page 23-12, Eq. 23.33
%            Cyril M. Harris, Ed.
%
cont0=(1./W_D).*exp(-zeta.*W_N.*TIME);
cont1=sin(W_D.*TIME);
cont2=cos(W_D.*TIME);
intg1=ACC.*exp(zeta.*W_N.*TIME).*cos(W_D.*TIME);
intg2=ACC.*exp(zeta.*W_N.*TIME).*sin(W_D.*TIME);
%
delta=cont0.*(cont1.*cumsum(intg1.*DT)-cont2.*cumsum(intg2.*DT));
%
aeq=w_n.^2.*(max(delta));
if(size(aeq,2) ~= 1) 
  aeq=aeq';
end
stime=toc;








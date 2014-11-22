function [W,A]=desa2(x, dt)

% The function DESA2 calculates frequency and amplitude using Teager Energy Operator (DESA-2 algorithm) 
% of the data x(n,m), where n is the number of points, and m is  
% the number of IMF components, by applying the Discrete
% Energy Separation Algorithm (DESA-2) that uses Teager
% Energy Operator, defined as e(n) = x(n)*x(n)-x(n-1)*x(n+1).
% 
% Refer to DESA-2 algorithm in pp. 3024-3051,
% IEEE Transactions on Signal Processing, Vol. 41, NO. 10, October 1993.
% The end points are set to be the same as the adjacent points.
%
% Calling sequence-
% [W,A]=desa2(x, dt)
%
% Input-
%	x	- 2-D matrix x(n,m) of data representing the IMF components
%	dt	- the sampling rate
% Output- 
%	W	- 2-D matrix W(n,m) of data, representing the frequency
%	A	- 2-D matrix A(n,m) of data, representing the amplitude
 
% Dan Xiang (JHU)	 	        March 7, 2002 Initial
% Jelena Marshak (NASA GSFC)    June 1, 2004 Modified
%                               (corrected the case when energy
%                               of data and its derivative are 
%                               equal to zero producing NaN value)
%

%----- Determine y(n) = x(n+1)-x(n-1)
[n, m] = size(x);
for i=2:n-1
   y(i,:) = x(i+1,:) - x(i-1,:);
end

%----- Add ending points
%----- to make them have equal size
y(1,:) = y(2,:);
y(n,:) = y(n-1,:);

E1=psi(x);
E2=psi(y);

W = real(0.5*acos(1 - E2./E1/2)/2/pi/dt);
A = real(2*E1./sqrt(E2));

% handle the special case
for j=1:n
for i=1:m
if(isnan(W(j,i)) | isnan(A(j,i)));
   disp('Warning: Energy of data and its derivative are equal to zero.');
   disp('Warning: j i E1 E2 A W:');
   str=[j i E1(j,i) E2(j,i) A(j,i) W(j,i)];
   disp(str);
   W(j,i)=W(j-1,i);
   A(j,i)=0.;
   disp('Fix    : j i E1 E2 A W:');
   str=[j i E1(j,i) E2(j,i) A(j,i) W(j,i)];
   disp(str);
end
end
end

%----- Force the ending points to be the same as the adjacent ones
W(2,:) = W(3,:);
W(1,:) = W(2,:);
W(n-1,:) = W(n-2,:);
W(n, :) = W(n-1, :);
A(2,:) = A(3,:);
A(1,:) = A(2,:);
A(n-1,:) = A(n-2,:);
A(n,:) = A(n-1,:);

%----- Energy operator function: e = x(n)*x(n)-x(n-1)*x(n+1)
function e = psi(x)

[r, c]=size(x);
for i=2:r-1
   e(i,:)=x(i, :).*x(i,:) - x(i+1,:).*x(i-1,:);
end
% add ending points
e(1,:)=e(2,:);
e(r,:)=e(r-1,:);
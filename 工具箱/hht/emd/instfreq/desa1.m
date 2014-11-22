function [W,A]=desa1(x, dt)

% The function DESA1 calculates frequency and amplitude using Teager Energy Operator (DESA-1 algorithm)
% for the data x(n,m), where n is the number of points, and m is  
% the number of IMF components, by applying the the Discrete
% Energy Separation Algorithm (DESA-1) that uses Teager 
% Energy Operator, defined as e(n) = x(n)*x(n)-x(n-1)*x(n+1).
%
% Refer to DESA-1 algorithm in pp. 3024-3051,
% IEEE Transactions on Signal Processing, Vol. 41, NO. 10, October 1993.
% The end points are set to be the same as the adjacent points.
%
% Calling sequence-
% [W,A]=desa1(x, dt)
%
% Input-
%	x	- 2-D matrix x(n,m) of data representing the IMF components
%	dt	- the sampling rate
% Output- 
%	W	- 2-D matrix W(n,m) of data, representing the frequency
%	A	- 2-D matrix A(n,m) of data, representing the amplitude
%

% Dan Xiang (JHU)	 	        March 7, 2002 Initial
% Jelena Marshak (NASA GSFC)    June 1, 2004 Modified
%                               (corrected the case when energy
%                               of data and its derivative are 
%                               equal to zero producing NaN value)

y=diff(x);
[n, m] = size(y);

%----- Calculate the frequency and amplitude
% for y(n) = x(n) - x(n-1), we repeat the first point
% for y(n+1) = x(n+1) - x(n), we repeat the last point
% to make them have equal size
for i=1:m
   yn(:,i) = [y(1,i); y(:,i)];
   yn1(:,i) = [y(:,i); y(n,i)];
end

% apply energy operator to the original signal
E1=psi(x);

% average E on two opposite asymmetric derivatives 
temp = (psi(yn)+psi(yn1))./E1/4;

% extract frequency and amplitude
W = real(acos(1 - temp)/2/pi/dt);
A = real(sqrt(E1./(1-(1- temp).*(1-temp))));

% handle the special case
for j=1:n+1
for i=1:m
if (isnan(W(j,i)) | isnan(A(j,i)))
   disp('Warning: Energy of data and its derivative are equal to zero.');
   disp('Warning: j i E1 temp A W:');
   str=[j i E1(j,i) temp(j,i) A(j,i) W(j,i)];
   disp(str);
   W(j,i)=W(j-1,i);
   A(j,i)=0.;
   disp('Fix    : j i E1 temp A W:');
   str=[j i E1(j,i) temp(j,i) A(j,i) W(j,i)];
   disp(str);
end
end
end
clear temp;

%----- Force the ending points to be the same as the adjacent ones
W(2,:) = W(3,:);
W(1,:) = W(2,:);
W(n,:) = W(n-1,:);
W(n+1, :) = W(n, :);
A(2,:) = A(3,:);
A(1,:) = A(2,:);
A(n,:) = A(n-1,:);
A(n+1,:) = A(n,:);

%----- Energy operator function: e = x(n)*x(n)-x(n-1)*x(n+1)
function e = psi(x)

[r, c]=size(x);
for i=2:r-1
   e(i,:)=x(i, :).*x(i,:) - x(i+1,:).*x(i-1,:);
end
% add ending points
e(1,:)=e(2,:);
e(r,:)=e(r-1,:);
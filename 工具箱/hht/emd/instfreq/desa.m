function [W,A]=desa(x, dt)

% The function DESA calculates frequency and amplitude using Teager Energy Operator 
% for the data x(n,m), where n is the number of points, and m is  
% the number of IMF components, by applying the Energy Separation
% Algorithm that uses Teager Energy Operator, defined as
% e(n) = x(n)*x(n)-x(n-1)*x(n+1).
% 
% Refer to CESA algorithm in pp. 3024-3051,
% IEEE Transactions on Signal Processing, Vol. 41, NO. 10, October 1993. 
% The end points are set to be the same as the adjacent points.
%
% Calling sequence-
% [W,A]=desa(x, dt)
%
% Input-
%	x	- 2-D matrix x(n,m) of data representing the IMF components
%	dt	- the sampling rate
% Output- 
%	W	- 2-D matrix W(n,m) of data, representing the frequency
%	A	- 2-D matrix A(n,m) of data, representing the amplitude
%

% Jelena Marshak (NASA GSFC)    June 1, 2004 Modified
%                               (corrected the case when energy
%                               of data and its derivative are 
%                               equal to zero producing NaN value)

y=diff(x);
[n, m] = size(y);
for i=1:m
   x1(:,i) = [y(:,i); y(n,i)];
end

[row, col]=size(x);
for i=1:col
   S=x(2:row-1, i).*x(2:row-1, i) - x(1:row-2, i).*x(3:row, i);
   E1(:, i)=[S(1); S; S(row-2)];	% ending points
   
   S=x1(2:row-1, i).*x1(2:row-1, i) - x1(1:row-2, i).*x1(3:row, i);
   E2(:, i)=[S(1); S; S(row-2)];
end

W = real(sqrt(E2./E1)/2/pi/dt);
A = E1./real(sqrt(E2));

% handle the special case
for j=1:n+1
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

clear S;
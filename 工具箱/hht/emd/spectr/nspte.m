function [h,xs,w] = nspte(data,nyy,t0,t1)

% The function NSPTE calculates the spectrum using Teager Energy Operator
% applied to data(n,k), where n is the number of data points
% and k is the number of IMF components. 
% The Discrete Energy Separation Algorithm (DESA-1) that applies 
% Teager Energy Operator is used to extract the instantaneous frequency
% and amplitude from the data.
%
% Non MATLAB Library routine used: DESA1M.
%
% Note: Y-axis range is [min-frequency,max-frequency].
%
% Functions contour(xs,w,h) or img(xs,w,h) can be used
% to plot the contour of the spectrum. 
%
% Calling sequence-
% [h,xs,w]=nspte(data,ny,t0,t1)
%                                                
% Input-
%	data	- 2-D matrix data(n,k) of IMF components
%	ny	    - the frequency resolution
%	t0	    - the start time
%	t1	    - the end time
% Output-
%	h	    - 2-D matrix of the spectrum
%	xs	    - vector representing the time-axis
%	w	    - vector representing the frequency-axis
 
% Z. Shen (Caltech)	July 2, 1995	Initial
% D. Xiang (JHU)	March 25, 2002	Modified 

[npt,knb] = size(data);            %read the dimensions
dt=(t1-t0)/(npt-1);

%-----Energy separation algorithm ----------!
[omg,a]=desa1m(data,dt);

clear data
%----- get local frequency -----------------!
wmx=max(max(omg))
wmn=min(min(omg))
dw=wmx-wmn;
 if wmn<0.
   error('Error: negative frequency appears!');
 end
 clear p;
%----- Construct the ploting matrix --------!
disp('Maximum Amplitude =');
disp(max(max(a)));
h1=zeros(npt,nyy+1);
p=round(nyy*(omg-wmn)/dw)+1;
for j1=1:npt
   for i1=1:knb
      ii1=p(j1,i1);
      h1(j1,ii1)=h1(j1,ii1)+a(j1,i1);
   end
end
%---- the results ------------------!
w=linspace(wmn,wmx,nyy+1)';
xs=linspace(t0,t1,npt)';
h=flipud(rot90(abs(h1)));

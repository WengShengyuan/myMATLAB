function [h,xs,w] = nsp7(data,nyy,t0,t1)

%
%    [h,xs,w]=nsp(data,nyy,t0,t1):
%
%    Function to generate a smoothed HHT spectrum of data(n,k)
%    in time-frequency space, where 
%    n specifies the length of time series, and 
%    k is the number of IMF components.
%
%    Input-
%	data	- 2-D matrix data(n,k) of IMF components
%	nyy	- the frequency resolution
%	t0	- the start time
%	t1	- the end time
%    Output-
%	h	- 2-D matrix of the HHT spectrum, where
%		  1st dimension specifies the number of frequencies,
%		  2nd dimension specifies the number of time values
%	xs	- vector that specifies the time-axis values
%	w	- vector that specifies the frequency-axis values
%
%    Z. Shen (JHU)		July 2, 1995 Initial
%    J. Marshak (NASA GSFC)	Jan. 28, 2004 Edited
%
%    Notes-
%    MATLAB library function 'hilbert()' is used to calculate the
%    Hilbert transform.
%    Example, [h,xs,w] = nsp7(lod78_p',200,1,3224).
%    Functions 'contour()' or img() can be used to view the spectrum,
%    for example contour(xs,w,h) or img(xs,w,h).
% 
%    Temporary remarks-
%    'nsp7.m' is similar to 'nsp.m': the latter uses 6 (instead of 8)
%     smoothing points. Suggestion : 
%     add ni0 parameter that specifies the number of smoothing points.

%----- Get dimensions (number of time points and components)
[npt,knb] = size(data);

%----- Get time interval
dt=(t1-t0)/(npt-1);

%----- Apply Hilbert Transform
data=hilbert(data);
a=abs(data);
%omg=abs(diff(data)./data(1:npt-1,:)/(2*pi*dt));
omg=abs(diff(unwrap(angle(data))))/(2*pi*dt);

%----- Smooth amplitude and frequency
filtr=fir1(6,.1);
for i=1:knb
   a(:,i)=filtfilt(filtr,1,a(:,i));
   omg(:,i)=filtfilt(filtr,1,omg(:,i));
end
for i=1:knb
   a(:,i)=filtfilt(filtr,1,a(:,i));
   omg(:,i)=filtfilt(filtr,1,omg(:,i));
end
clear filtr data

%----- Get local frequency
wmx=max(max(omg))
wmn=min(min(omg))
dw=wmx-wmn;
if wmn<0.
   error('Error: negative frequency appears!');
end

%----- Construct the ploting matrix
clear p;
h1=zeros(npt-1,nyy+1);
p=round(nyy*(omg-wmn)/dw)+1;
for j1=1:npt-1
   for i1=1:knb
      ii1=p(j1,i1);	
      h1(j1,ii1)=h1(j1,ii1)+a(j1,i1);
   end
end

%----- Do 3-point to 1-point averaging
[nx,ny]=size(h1);
n1=fix(nx/3);
h=zeros(n1,ny);
for i1=1:n1
   h(i1,:)=(h1(3*i1,:)+h1(3*i1-1,:)+h1(3*i1-2,:))/3.;
end
clear h1;

%----- Do 3-points smoothing in x-direction
fltr=1./3*ones(3,1);
for j1=1:ny
   h(:,j1)=filtfilt(fltr,1,h(:,j1));
end
clear fltr;

%----- Define the results
w=linspace(wmn,wmx,ny)';
xs=linspace(t0,t1,n1)';
h=flipud(rot90(abs(h)));

function [h,xs,w] = nspunfilt(data,nyy,t0,t1)

% The function NSPUNFILT generates the HHT spectrum
% of data(n,k) in time-frequency space, where 
% n specifies the length of time series, and 
% k is the number of IMF components.
% Negative frequency is forced to be zero.
%
% MATLAB Library function HILBERT is used to calculate the Hilbert transform.
%
% Example, [h,xs,w] = nspunfilt(lod78_p',200,1,3224).
%
% Functions CONTOUR and IMG can be used to view the spectrum,
%    for example contour(xs,w,h) or img(xs,w,h).
%
% Calling sequence-
% [h,xs,w]=nspunfilt(data,nyy,t0,t1)
%
% Input-
%	data	- 2-D matrix data(n,k) of IMF components
%	nyy	    - the frequency resolution
%	t0	    - the start time
%	t1	    - the end time
% Output-
%	h	    - 2-D matrix of the HHT spectrum, where
%		    1st dimension specifies the number of frequencies,
%		    2nd dimension specifies the number of time values
%	xs	    - vector that specifies the time-axis values
%	w	    - vector that specifies the frequency-axis values
 
% Z. Shen (JHU)		    July 2, 1995 Initial
% D. Xiang (JHU)		March 25, 2002  Modified

%----- Get dimensions (number of time points and components)
[npt,knb] = size(data);

%----- Get time interval
dt=(t1-t0)/(npt-1);

%----- Apply Hilbert Transform
data=hilbert(data);
a=abs(data);
omg=diff(unwrap(angle(data)))/(2*pi*dt);

%---- Force the negative omg to be zero, DX.
omg=(omg+abs(omg))/2.;

%----- Add the last row to omg to preserve the dimension
omg=[omg;omg(npt-1,:)];   
clear data

%----- Get local frequency
wmx=max(max(omg))
wmn=min(min(omg))
dw=wmx-wmn;
 if wmn<0.
   error('Error: negative frequency appears!');
 end

%----- Construct the ploting matrix
clear p;
h1=zeros(npt,nyy+1);
p=round(nyy*(omg-wmn)/dw)+1;
for j1=1:npt
   for i1=1:knb
      ii1=p(j1,i1);
      h1(j1,ii1)=h1(j1,ii1)+a(j1,i1);
   end
end

%----- Define the results
w=linspace(wmn,wmx,nyy+1)';
xs=linspace(t0,t1,npt)';
h=flipud(rot90(abs(h1)));

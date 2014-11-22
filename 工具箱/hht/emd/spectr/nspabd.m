function [h,xs,w] = nspabd(data,nyy,minw,maxw,t0,t1)

% The function NSPABD generates a smoothed HHT damping spectrum
% in time-frequency space, with fixed frequency range for data(n,k), 
% where n specifies the length of time series, and 
% k - the number of IMF components.
% Negative frequency sign is reversed.
%
% MATLAB Library function HILBERT is used to calculate the Hilbert transform.
%
% Example, [h,xs,w] = nspabd(lod78_p',200,0,0.12,1,3224).
%
% Functions CONTOUR or IMG can be used to view the spectrum,
%    for example contour(xs,w,h) or img(xs,w,h).
%
% Calling sequence-
% [h,xs,w]=nspabd(data,ny,minw,maxw,t0,t1)
%
% Input-
%	data	- 2-D matrix data(n,k) of IMF components
%	nyy	- the frequency resolution
%	minw	- the minimum frequency
%	maxw	- the maximum frequency
%	t0	- the start time
%	t1	- the end time
% Output-
%	h	- 2-D matrix of the HHT damping spectrum, where
%		  1-st dimension specifies the number of frequencies,
%		  2-nd dimension specifies the number of time values 
%	xs	- vector that specifies the time-axis values
%	w	- vector that specifies the frequency-axis values
     
% Z. Shen (JHU)		July 2, 1995 Initial
% L.W. Salvino		Modified (added damping)		


%----- Get dimensions
[npt,knb] = size(data);

%----- Get time interval
dt=(t1-t0)/npt;

%----- Apply Hilbert Transform
data=hilbert(data);
a=abs(data);
omg=abs(diff(data)./data(1:npt-1,:)/(2*pi*dt));

%----- Calculate freq-time dependent damping
dfterm=diff(a)./(dt.*a(1:npt-1,:));
denom=(2.*pi.*omg).^2+dfterm.^2;
a=((2.*dfterm).^2)./denom;

%----- Do 5-points smoothing
filtr=fir1(8,.1);
for i=1:knb
   a(:,i)=filtfilt(filtr,1,a(:,i));
   omg(:,i)=filtfilt(filtr,1,omg(:,i));
end
for i=1:knb
   a(:,i)=filtfilt(filtr,1,a(:,i));
   omg(:,i)=filtfilt(filtr,1,omg(:,i));
end

%----- Fix values outside the given frequency range
for i=1:knb
   for i1=1:npt-1
      if omg(i1,i) >=maxw,
         omg(i1,i)=maxw;
	 a(i1,i)=0;
      elseif omg(i1,i)<=minw,
         omg(i1,i)=minw;
	 a(i1,i)=0;
      else
      end
   end
end

clear filtr data
%----- Get local frequency
dw=maxw - minw;
wmx=maxw;
wmn=minw;

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

%---- Do 3-point to 1-point averaging
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
w=linspace(wmn,wmx,ny-1)';
xs=linspace(t0,t1,n1)';
h=flipud(rot90(h));
h=h(1:ny-1,:);


function [h,xs,w] = hhtpab(data,nyy,minw,maxw,t0,t1,ni0)

% The function HHTPAB generates a smoothed phase image of Hilbert spectrum
% with fixed frequency range for data(n,k), where 
% n specifies the length of time series, and 
% k - the number of IMF components.
% The negative frequency is reversed in sign.
% MATLAB Library function HILBERT is used to perform Hilbert transform.
%
% To view the image use IMG function, for example,
%
% [nta,tscale,fscale]=hhtpab(lod78_p',200,0.,0.12,1,3224,5);
% img(tscale,fscale,nta);
%
% Calling sequence-
%   [h,xs,w]=hhtpab(data,nyy,minw,maxw,t0,t1,ni0)
%
% Input-
%   data	- 2-D matrix data(n,k) of IMF components
%	nyy     - the frequency resolution
%	minw	- the minimum frequency
%	maxw	- the maximum frequency
%	t0	    - the start time
%	t1	    - the end time
%	ni0	    - number of vertical smooth points (Ex. ni0=5)
% Output-
%	h	    - 2-D matrix of the HHT phase, where
%		    1-st dimension specifies the number of frequencies,
%		    2-nd dimension specifies the number of time values 
%	xs	    - vector that specifies the time-axis values
%	w	    - vector that specifies the frequency-axis values
     
% Z. Shen (JHU)		    July 2, 1995 Initial

%----- Get dimensions (number of time points and components)
[npt,knb] = size(data);

%----- Get time interval
dt=(t1-t0)/npt;

%----- Apply Hilbert Transform [ exp(j*pi)=-1+0.0j ]
data=hilbert(data);
a=-angle(exp(j*pi)*data);
omg=abs(diff(data)./data(1:npt-1,:)/(2*pi*dt));

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
      if (ii1 > 1)&(ii1 <= nyy)
         h1(j1,ii1-1)=h1(j1,ii1);
	 h1(j1,ii1+1)=h1(j1,ii1);
      end
   end
end

%----- Do 3-points to 1-point averaging
[nx,ny]=size(h1);
n1=fix(nx/3);
h=zeros(n1,ny);

for i1=1:n1
   h(i1,:)=(h1(3*i1,:)+h1(3*i1-1,:)+h1(3*i1-2,:))/3.;
%    h(i1,:)=h1(3*i1-1,:);
end

clear h1;
%----- Smooth ni0-points in y-direction
fltr=1./ni0*ones(ni0,1);
for j1=1:n1
   h(j1,:)=filtfilt(fltr,1,h(j1,:));
end
clear fltr;

%----- Define results
w=linspace(wmn,wmx,ny-1)';
xs=linspace(t0,t1,n1)';
h=flipud(rot90(h));
h=h(1:ny-1,:);

function [h,xs,w] = hhtpabunfilt(data,nyy,minw,maxw,t0,t1)

% The function HHTPABUNFILT generates a phase image of Hilbert spectrum 
% with fixed frequency range for data(n,k), where 
% n specifies the length of time series, and 
% k - the number of IMF components.
% The negative frequency is reversed in sign.
% MATLAB Library function HILBERT is used to perform Hilbert transform.
%
% To view the image use IMG function, for example,
%
% [nta,tscale,fscale]=hhtpabunfilt(lod78_p',200,0.,0.12,1,3224);
% img(tscale,fscale,nta);
%
% Calling sequence-
%   [h,xs,w]=hhtpabunfilt(data,nyy,minw,maxw,t0,t1)
%
%   Input-
%	data	- 2-D matrix data(n,m) of IMF components
%	nyy	    - the frequency resolution
%	minw	- the minimum frequency
%	maxw	- the maximum frequency
%	t0	    - the start time
%	t1	    - the end time
%   Output-
%	h	    - 2-D matrix of the HHT phase, where
%		    1st dimension specifies the number of frequencies
%		    2nd dimension specifies the number of time values 
%	xs	    - vector that specifies the time-axis values
%	w	    - vector that specifies the frequency-axis values
    
%   Z. Shen (JHU)		July 2, 1995 Initial
%   D. Xiang (JHU)		March 26, 2002 Modified

%----- Get dimensions (number of time points and components)
[npt,knb] = size(data);

%----- Get time interval
dt=(t1-t0)/(npt-1);

%----- Apply Hilbert Transform [ exp(j*pi)=-1.0+0.0j ]
data=hilbert(data);
a=-angle(exp(j*pi)*data);
omg=abs(diff(data)./data(1:npt-1,:)/(2*pi*dt));

%---- Force the negative omg to be zero, DX.
omg=(omg+abs(omg))/2.;

%---- Add the last row to omg to preserve the dimension
omg=[omg;omg(npt-1,:)];
   
clear data

%----- Fix the frequency values outside the given frequency range
for i=1:knb
   for i1=1:npt
      if omg(i1,i) > maxw,
         omg(i1,i)=maxw;
	 a(i1,i)=0;
      elseif omg(i1,i)< minw,
         omg(i1,i)=minw;
	 a(i1,i)=0;
      else
      end
   end
end

%----- Get local frequency
dw=maxw - minw;
wmx=maxw;
wmn=minw;

%----- Construct the ploting matrix
clear p;
h1=zeros(npt,nyy+1);
p=round(nyy*(omg-wmn)/dw)+1;

for j1=1:npt
   for i1=1:knb
      ii1=p(j1,i1);	
      h1(j1,ii1)=h1(j1,ii1)+a(j1,i1);
      if (ii1 > 1)&(ii1 <= nyy)
         h1(j1,ii1-1)=h1(j1,ii1);
	 h1(j1,ii1+1)=h1(j1,ii1);
      end
   end
end

%----- Define results
w=linspace(wmn,wmx,nyy+1)';
xs=linspace(t0,t1,npt)';
h=flipud(rot90(h1));
h=h(1:nyy,:);

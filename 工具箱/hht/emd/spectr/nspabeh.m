function [h,xs,w] = nspabeh(data,nyy,minw,maxw,t0,t1)

% The function NSPABEH generates the improved HHT spectrum of data(n,k)  
% in time-frequency space, where  
% n specifies the length of time series, and 
% k is the number of IMF components.
% The frequency-axis range is prefixed.
% Function FAH is used to calculate the frequency and amplitude of the data.
%       
% Non MATLAB Library function used: FAH. 
%
% Example, [h,xs,w] = nspabeh(lod78_p',200,0,0.12,1,3224).
%
% Functions CONTOUR or IMG can be used to view the spectrum,
%    for example contour(xs,w,h) or img(xs,w,h).
%
% Calling sequence-
% [h,xs,w] = nspabeh(data,nyy,minw,maxw,t0,t1)
%
% Input-
%	data	- 2-D matrix data(n,k) of IMF components
%	nyy	- the frequency resolution
%	minw	- the minimum frequency
%	maxw	- the maximum frequency
%	t0	- the start time
%	t1	- the end time
% Output-
%	h	- 2-D matrix of the HHT spectrum, where
%		  the 1st dimension specifies the number of frequencies,
%		  the 2nd dimension specifies the number of time values
%	xs	- vector that specifies the time-axis values
%	w	- vector that specifies the frequency-axis values
 
% Z. Shen (JHU)		        July 2, 1995 Initial
% D. Xiang (JHU)		    March 27, 2002 Modified
%				            (removed smoothing)
% J. Marshak (NASA GSFC)	Feb. 11, 2004 Modified
%				            (replaced hfam() by 'fah()')

%----- Get dimensions
[npt,knb] = size(data);

%----- Get time interval
dt=(t1-t0)/(npt-1);

%----- Calculate frequency and amplitude
[omg,a]=fah(data,dt);

%----- Limit frequency and amplitude   
clear data;
for i=1:knb
   for i1=1:npt
      if omg(i1,i) >maxw,
         omg(i1,i)=maxw;
	 a(i1,i)=0;
      elseif omg(i1,i)<minw,
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
   end
end

%----- Define the output parameters
w=linspace(wmn,wmx,nyy+1)';
xs=linspace(t0,t1,npt)';
h=flipud(rot90(h1));
h=h(1:nyy,:);

function [h,xs,w] = nspabeunfilt(data,nyy,minw,maxw,t0,t1)
%
%    [h,xs,w] = nspabeunfilt(data,nyy,minw,maxw,t0,t1):
%
%    Function to generate an improved HHT spectrum of data(n,k)  
%    in time-frequency space, where  
%    n specifies the length of time series, and 
%    k is the number of IMF components.
%    The frequency-axis range is prefixed.
%    Negative frequency is forced to be zero.
%
%    Input-
%	data	- 2-D matrix data(n,k) of IMF components
%	nyy	- the frequency resolution
%	minw	- the minimum frequency
%	maxw	- the maximum frequency
%	t0	- the start time
%	t1	- the end time
%    Output-
%	h	- 2-D matrix of the HHT spectrum, where
%		  1-st dimension specifies the number of frequencies,
%		  2-nd dimension specifies the number of time values
%	xs	- vector that specifies the time-axis values
%	w	- vector that specifies the frequency-axis values
%
%    Z. Shen (JHU)		July 2, 1995 Initial
%    D. Xiang (JHU)		March 27, 2002 Modified
%    J. Marshak (NASA GSFC)	Jan. 28, 2004 Edited
%
%    Notes-
%    Non MATLAB library function 'hilbt()' is used to calculate the
%    Hilbert transform.
%    Example, [h,xs,w] = nspabeunfilt(lod78_p',200,0,0.12,1,3224).
%    Functions 'contour()' or img() can be used to view the spectrum,
%    for example contour(xs,w,h) or img(xs,w,h).
%

%----- Get dimensions (number of time points and components)
[npt,knb] = size(data);

%----- Get time interval
dt=(t1-t0)/(npt-1);

%----- Apply Hilbert Transform
data=hilbt(data);
a=abs(data);
omg=diff(unwrap(angle(data)))/(2*pi*dt);

%---- Force the negative omg to be zero (DX)
omg=(omg+abs(omg))/2.;

%----- Add the last row to omg to preserve the dimension
omg=[omg;omg(npt-1,:)];

%----- Limit frequency and amplitude   
clear data
for i=1:knb
   for i1=1:npt
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

%----- Define the results
w=linspace(wmn,wmx,nyy+1)';
xs=linspace(t0,t1,npt)';
h=flipud(rot90(h1));
h=h(1:nyy,:);
clear h1

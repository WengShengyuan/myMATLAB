function [h,xs,w] = hspabm(data,nyy,min_t,max_t,t0,t1)
%
%    [h,xs,w] = hspabm(data,nyy,min_t,max_t,t0,t1):
%    Function to generate a Hilbert spectrum on data(n,k)  
%    in time-period space, where  
%    n specifies the length of time series, and 
%    k is the number of IMF components.
%    The period-axis range is prefixed.
%
%    Input-
%	data	- 2-D matrix data(n,k) of IMF components
%	nyy	- the period resolution
%	min_t	- the minimum period
%	max_t	- the maximum period
%	t0	- the start time
%	t1	- the end time
%    Output-
%	h	- 2-D matrix of the HHT spectrum, where
%		  1st dimension specifies the number of periods,
%		  2nd dimension specifies the number of time values
%	xs	- vector that specifies the time-axis values
%	w	- vector that specifies the period-axis values
%
%    Z. Shen (JHU)		July 2, 1995 Initial
%    D. Xiang (JHU)		March 26, 2002 Modified
%    J. Marshak (NASA GSFC)	Jan. 28, 2004 Edited
%
%    Notes-
%    MATLAB library function 'hilbert()' is used to calculate the
%    Hilbert transform.
%    Example, [h,xs,w] = hspabm(lod78_p',200,5,250000,1,3224).
%    Functions 'contour()' or img() can be used to view the spectrum,
%    for example contour(xs,w,h) or img(xs,w,h).
% 
%    Temporary remarks-
%    Changed the function name,
%    was  'hspab_m()' for the code named as 'hspabm.m'.

%----- Get dimensions (number of time points and components)
[npt,knb] = size(data);

%----- Get time interval
dt=(t1-t0)/(npt-1);

%-----Apply Hilbert Transform
data=hilbert(data);
a=abs(data);
omg=abs(diff(data)./data(1:npt-1,:)/(2*pi*dt));
%omg=abs(diff(unwrap(angle(data))))/(2*pi*dt);

%----- Add the last row to omg to preserve the dimension
omg=[omg;omg(npt-1,:)];

%----- Limit period and amplitude
omg=1../omg;   
for i=1:knb
   for i1=1:npt
      if omg(i1,i) >max_t,
         omg(i1,i)=max_t;
	 a(i1,i)=0;
      elseif omg(i1,i)<min_t,
         omg(i1,i)=min_t;
	 a(i1,i)=0;
      else
      end
   end
end

clear data
dtt=max_t - min_t;
tmx=max_t;
tmn=min_t;
clear p;

%----- Construct the ploting matrix
h1=zeros(npt,nyy+1);
p=round(nyy*(omg-tmn)/dtt)+1;
for j1=1:npt
   for i1=1:knb
      ii1=p(j1,i1);	
      h1(j1,ii1)=h1(j1,ii1)+a(j1,i1);
   end
end

%----- Define the results
w=linspace(tmn,tmx,nyy+1)';
xs=linspace(t0,t1,npt)';
h=flipud(rot90(h1));
h=h(1:nyy,:);

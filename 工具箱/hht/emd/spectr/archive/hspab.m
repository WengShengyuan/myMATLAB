function [h,xs,w] = hspab(data,nyy,min_t,max_t,t0,t1)
%    [h,xs,w] = hspab(data,nyy,min_t,max_t,t0,t1):
%    Function to generate a smoothed Hilbert spectrum of data(n,k)  
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
%    J. Marshak (NASA GSFC)	Jan. 28, 2004 Edited
%
%    Notes-
%    MATLAB library function 'hilbert()' is used to calculate the
%    Hilbert transform.
%    Example, [h,xs,w] = hspab(lod78_p',200,5,25000,0,3224).
%    Functions 'contour()' or img() can be used to view the spectrum,
%    for example contour(xs,w,h) or img(xs,w,h).
% 
%    Temporary remarks-
%    dt calculation is not consistent

%----- Get dimensions (number of time points and components)
[npt,knb] = size(data);

%----- Get time interval
dt=(t1-t0)/npt;

%-----Apply Hilbert Transform
data=hilbert(data);
a=abs(data);
omg=abs(diff(data)./data(1:npt-1,:)/(2*pi*dt));

%----- Smooth
filtr=fir1(8,.1);
for i=1:knb
   a(:,i)=filtfilt(filtr,1,a(:,i));
   omg(:,i)=filtfilt(filtr,1,omg(:,i));
end
for i=1:knb
   a(:,i)=filtfilt(filtr,1,a(:,i));
   omg(:,i)=filtfilt(filtr,1,omg(:,i));
end

%----- Limit period and amplitude
omg=1../omg;
for i=1:knb
   for i1=1:npt-1
      if omg(i1,i) >=max_t,
         omg(i1,i)=max_t;
	 a(i1,i)=0;
      elseif omg(i1,i)<=min_t,
         omg(i1,i)=min_t;
	 a(i1,i)=0;
      else
      end
   end
end

clear filtr data
dtt=max_t - min_t;
tmx=max_t;
tmn=min_t;

%----- Construct the ploting matrix
clear p;
h1=zeros(npt-1,nyy+1);
p=round(nyy*(omg-tmn)/dtt)+1;
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
w=linspace(tmn,tmx,ny-1)';
xs=linspace(t0,t1,n1)';
h=flipud(rot90(h));
h=h(1:ny-1,:);

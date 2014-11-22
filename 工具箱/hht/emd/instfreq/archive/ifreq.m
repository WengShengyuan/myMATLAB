function f=ifreq(x,t0,t1,n)
%
%    f=ifreq(x,t0,t1,n):
%
%    Function to generate a smoothed instantaneous frequency of x(n,1),
%    where n specifies the length of time series for one IMF component,
%    using an improved Hilbert transform.
%    Negative frequency sign is reversed.
%
%    Input-
%	data	- 2-D matrix x(n,1) of one IMF component
%	t0	- the start time
%	t1	- the end time
%       n	- the number of smooth-points
%    Output-
%	h	- 2-D matrix of the HHT spectrum, where
%		  1st dimension specifies the number of frequencies,
%		  2nd dimension specifies the number of time values
%	xs	- vector that specifies the time-axis values
%	w	- vector that specifies the frequency-axis values
%
%    Norden Huang (Caltech)	1997 Initial
%    J. Marshak (NASA GSFC)	Feb.11, 2004 Edited
%
%    Notes-
%    Non MATLAB Library function 'hilbt()' is used to calculate the
%    Hilbert transform.
%    Example, f = ifreq(lod78_pr(:,1),0,3224,3).
%    Function 'plot()' can be used to view the frequency,
%    for example plot(1:3224,f).

%----- Get dimensions
m=length(x);

%----- Get time interval
dt=(t1-t0)/m;

%----- Apply an improved Hilbert Transform
h=hilbt(x);

%----- Get the instantaneous frequency
h=abs(diff(unwrap(angle(h))));
h=[h' h(m-1)]'/(2*pi*dt);

%----- Smooth
q1=fir1(n,.001);
h=filtfilt(q1,1,h);
h=filtfilt(q1,1,h);      

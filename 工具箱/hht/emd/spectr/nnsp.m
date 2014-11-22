function [nt,tscale,fscale]=nnsp(data,t0,t1,fres,tres,fw0,fw1,tw0,tw1,ifmethod,normmethod,nfilter,lscale)

% The function NNSP generates and plots an improved HHT or zero-crossing 
% spectrum of data (or LOG of data) data(n,k) in time-frequency (or time-log frequency) space, 
% where n specifies the length of time series, and 
% k is the number of IMF components.
%
% Types of transform and normalization method are passed as arguments.
% All arguments except data, which is required, are optional.
% Optional arguments have default values assigned as follows:
%	t0=0; t1=max(size(data)-1); fres=400; tres=400; 
%	fw0= min(min(f)); fw1=max(max(f)); tw0=t0; tw1=t1;lscale=0;
% By default the regular scale is chosen. If the value of lscale is 
% non zero than the logarithmic scale is chosen.
%
% See help for FA function for details on 
%	ifmethod, normmethod and nfilter parameters.
% To display the output, use:
%	img(tscale,fscale,nt)
%	or
%	contour(tscale,fscale,nt)
%	or
%	do not ask for any outputs, and the spectrum
%	will be plotted in the current figure.
% Non MATLAB Library routines used in the function are: FA, NSPPLOT.
%
% Calling sequence-
% [nt,tscale,fscale] = nnsp(data[, t0][, t1][, fres][, tres][, fw0][, fw1]
% 	[,tw0][, tw1][, ifmethod][, normmethod][,nfilter][,lscale]) 
%
% Input-
%	data        - 2-D input data(n,k) that specifies IMFs
%	t0          - true start time
%	t1          - true end time
%	fres        - frequency resolution
%	tres        - time resolution
%	fw0         - minimum frequency
%	fw1         - maximum frequency
%	tw0         - minimum time
%	tw1         - maximum time
%	ifmethod    - nstantaneous frequency method
%	normmethod  - normalization method
%	nfilter     - number of points to filter by median
%   	lscale      - integer number that represents the scale identifier.
%
% Output-
%	nt          - 2-D matrix that specifies the spectrum
%	tscale      - vector that specifies the time axis values
%	fscale      - vector that specifies the frequency axis values
 
% Kenneth Arnold (NASA GSFC)	    	Summer, 2003 Initial
%	(Based on work by Z. Shen (JHU) July, 2 1995.)
% Jelena Marshak (NASA GSFC)		March 17, 2004 Modified
%					(Added the LOG scale option.) 

%----- Initialize the parameters
if nargin<1
    error('nsp: data argument must be passed');
end
if max(size(data)) < 3
    error('nsp: data must have 3 or more points');
end
if nargin<3
    t0 = [];
    t1 = [];
end
if nargin<5
    fres=[];
    tres=[];
end
if nargin<7
    fw0 = [];
    fw1 = [];
end
if nargin<9
    tw0=[];
    tw1=[];
end
if nargin<10
    ifmethod = [];
end
if nargin<11
    normmethod = [];
end
if nargin<12
    nfilter = [];
end
if nargin<13
    lscale = [];
end

if isempty(t0)
    t0 = 0;
end
if isempty(t1)
    t1 = max(size(data))-1;
end
if isempty(fres)
    fres=400;
end
if isempty(tres)
    tres=400;
end
if isempty(tw0)
    tw0=t0;
end
if isempty(tw1)
    tw1=t1;
end
if isempty(lscale)
    lscale=0;
end

%----- Define the time interval
dt=(t1-t0)/(max(size(data))-1);

%----- Get frequency and amplitude
[freq,amp] = fa(data,dt,ifmethod,normmethod,nfilter);

%----- Get frequency bounds
if isempty(fw0)
    fw0=min(min(freq));
end
if isempty(fw1)
    fw1=max(max(freq));
end

if fw0<0.
    warning('nsp: negative frequency encountered, setting frequency window to 0');
    fw0=0;
end

%----- Get the values to plot the spectrum
[nt,tscale,fscale] = nspplot(freq,amp,t0,t1,fres,tres,fw0,fw1,tw0,tw1,lscale);

%----- Plot the spectrum if no output arguments are passed
if nargout == 0
    img(tscale,fscale,nt);
end

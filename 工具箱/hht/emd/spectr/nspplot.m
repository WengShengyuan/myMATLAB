function [nt,tscale,fscale]=nspplot(f,a,t0,t1,fres,tres,fw0,fw1,tw0,tw1,lscale)

% The function NSPPLOT generates and plots the HHT spectrum of data (or log data) 
% in time-frequency (or time-log frequency) space based on given frequency 
% f(n,k) and amplitude a(n,k), where 
% n specifies the length of time series, and 
% k is the number of IMF components.
%
% First two arguments are required, others are optional.
% Optional arguments have default values assigned as follows:
%	t0=0; t1=max(size (f)); fres=400; tres=400; 
%	fw0= min(min(f)); fw1=max(max(f)); tw0=t0; tw1=t1;lscale=0;
% By default the regular scale is chosen. If the value of lscale is non
% zero then the logarithmic scale is chosen.
%
% Example, [nt,tscale,fscale]=nspplot(f,a,1,3224,200).
%
% To get an image plotted ask for no output, for example,
%	nspplot(f,a,1,3224,200).
% Functions CONTOUR and IMG can be used to view the spectrum, for example, 
%	contour(tscale,fscale,nt) or img(tscale,fscale,nt).
%
% Calling sequence-
% [nt,tscale,fscale]=
% nspplot(f,a[,t0][,t1][,fres][,tres][,fw0][,fw1][,tw0][,tw1][,lscale])
%
% Input-
%	f	    - 2-D matrix that specifies the frequency values
%	a	    - 2-D matrix that specifies the amplitude values
%	t0	    - the start time
%	t1	    - the end time
%	fres	- the frequency resolution
%	tres	- the time resolution
%	fw0	    - the minimum frequency
%	fw1	    - the maximum frequency
%	tw0	    - the minimum time
%	tw1	    - the maximum time
%	lscale	- integer number that represents the LOG scale identifier. % Output-
%	nt	    - 2-D matrix of the HHT spectrum, where
%		    1st dimension specifies the number of frequencies,
%		    2nd dimension specifies the number of time values
%	tscale	- vector that specifies the time-axis values
%	fscale	- vector that specifies the frequency-axis values
 
% Kenneth Arnold (NASA GSFC)		Summer, 2003 Initial
% Jelena Marshak (NASA GSFC)		March 17, 2004 Modified
%                                   	(added the LOG scale option)

%----- Check the input arguments
if nargin<2
    error('nspplot: both frequency and amplitude matrices required');
end
if size(f) ~= size(a)
    error('nspplot: frequency and amplitude matrix sizes differ');
end

%----- Specify default variables
if nargin < 4
    t0=[];
    t1=[];
end
if nargin < 6
    fres=[];
    tres=[];
end
if nargin<8
    fw0=[];
    fw1=[];
end
if nargin<10
    tw0=[];
    tw1=[];
end
if nargin<11
    lscale=[];
end

%----- Initialize default variables
if isempty(t0)
    t0=0;
    t1=max(size(f));
end
if isempty(fres)
    fres=400;
end
if isempty(tres)
    tres=fres;
end
if isempty(fw0)
    fw0=min(min(f));
    fw1=max(max(f));
end
if isempty(tw0)
    tw0=t0;
    tw1=t1;
end
if isempty(lscale)
    lscale=0;
end

%----- Check the frequency range
if abs(fw0-fw1)/fres<1e-10
    warning('nspplot: frequency is nearly constant; giving an artificial range of +/- 1');
    fw0=fw0-.5;
    fw1=fw1+.5;
end

%----- Get dimensions
[npt,nimf]=size(f);

%----- Set the log scale values if requested
if lscale ~= 0;
    small=0.000001;
    if fw0 == 0;
       fw0=small;
    end
    for i=1:nimf;
        % Eliminate negative and zero values to apply LOG
        for j=1:npt;
        if (f(j,i) <= 0);
            f(j,i)=small;
            a(j,i)=small;
        end
        end
    end
    fw0=log(fw0);
    fw1=log(fw1);
    a=log(a);
    f=log(f);
end

%----- Flip frequency and amplitude if necessary
if npt < nimf
    f=f';
    a=a';
    [npt,nimf]=size(f);
end

%----- Get local frequency and time
fw=fw1-fw0;
tw=tw1-tw0;

%----- Get time interval
dt=(t1-t0)/(npt-1);

%----- Construct the ploting matrix
sidx=floor((tw0-t0)/dt)+1;
eidx=ceil((tw1-t0)/dt)+1;
nidx=eidx-sidx+1;

if tres>nidx
    tres=nidx;
end

nt=zeros(tres,fres);
p=round((fres-1)*(f-fw0)/fw)+1;

%----- Map vector from point space into block space

t=ceil((1:nidx)*tres/nidx);
for x=sidx:eidx
    for imf=1:nimf
        freqidx=p(x,imf);	
        if (freqidx >= 1 & freqidx <= fres)
            tx = t(x-sidx+1);
            nt(tx,freqidx)=nt(tx,freqidx)+a(x,imf);
        end
    end
end

%----- Define the output
if (lscale == 0)
    nt=abs(nt);
end
fscale=linspace(fw0,fw1,fres)';
tscale=linspace(tw0,tw1,tres)';
nt=flipud(rot90((nt)));

%----- Plot if no output arguments are passed
if nargout == 0
    img(tscale,fscale,nt);
end

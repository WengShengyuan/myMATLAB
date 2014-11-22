function [f,a] = fa(data,dt,ifmethod,normmethod,nfilter)

% The function FA computes a frequency and amplitude of data(n,k), where 
% n specifies the length of time series, and k is the number of IMFs.
% The user has a choice to choose the instantaneous frequency and
% normalization methods. Nature of the arcosine method suggests not 
% to use the latter to process the residue component.
% First 2 arguments are required. If not passed the rest is set to have 
% default values: the frequency and amplitude is calculated using Hilbert
% method with spline normalization and no smoothing of data.
%
% Non MATLAB Library routines used in the function are:
% 	FAACOS, FAH, FAZ, 
%	BLOCKNORMALIZE, SPLINENORMALIZE, HILBERTNORMALIZE, MEDIANFILTER.
%
% Ifmethod options:
%    'hilbert'	:use Hilbert transform (function FAH ),
%		 normalization of input data recommended but not required
%    'acos'     :use arccosine method (function FAACOS ),
%		 normalization of input data required
%    'zc'       :use Generalized Zero-Crossing method (function FAZ )
%		 normalization of input data not recommended
%
% Normmethod options:
%    'none'	:no normalization, recommended for 'zc' option
%    'spline'	:spline normalization, recommended for 'hilbert' 
%		 and 'acos' options
%    'hilbert'	:Hilbert amplitude normalization
%
% Calling sequence-
% [f,a] = fa(data,dt[,ifmethod][,normmethod][,nfilter])
%
% Input-
%	data		- 2-D matrix of IMF components
%	dt		    - time increment per point
%	ifmethod	- method of determining an instantaneous
%			    frequency (and amplitude)
%	normmethod	- normalization method
%	nfilter		- number of points to use for filter
% Output-
%	f		    - 2-D matrix f(n,k) that specifies frequency
%	a		    - 2-D matrix a(n,k) that specifies amplitude
 
% Kenneth Arnold (NASA GSFC)	Summer 2003, Initial

%----- Define default parameters
if nargin<3; ifmethod = []; end
if nargin<4; normmethod = []; end
if nargin<5; nfilter=[]; end

if isempty(ifmethod); ifmethod = @fah; end
% normmethod defaults below
if isempty(nfilter); nfilter=0; end

%----- Get the dimensions
[npt,nIMF]=size(data);
flipped=0;

if npt<nIMF
    %----- Flip the data
    data=data';
    flipped=1;
    [npt, nIMF]=size(data);
end

% Translate old-style text methods to new-style function handles
if isequal(class(ifmethod),'char')
    ifmethod = ifmethod2handle(ifmethod);
    if isempty(ifmethod)
        error ('fa: unknown frequency method');
    end
elseif ~isequal(class(ifmethod), 'function_handle')
    error ('fa: ifmethod must be either a string (depreciated) or a function handle.');
end

if isempty(normmethod)
    if isequal(ifmethod, @fah) | isequal(ifmethod, @faacos)
        normmethod = @splinenormalize;
    end
    % otherwise, leave normmethod empty
end

%----- Normalize data if requested
if ~isempty(normmethod)
    if isequal(class(normmethod), 'char')
        switch normmethod
            case 'block'; normmethod = @blocknormalize;
            case 'spline';  normmethod = @splinenormalize;
            case 'hilbert'; normmethod = @hilbertnormalize;
            case 'none'; normmethod = [];
            otherwise
                error ('fa: unknown normalization method');
        end
    elseif ~isequal(class(normmethod), 'function_handle')
        error ('fa: normmethod must be either a string (depreciated) or a function handle.');
    end
    
    [data,na]=feval(normmethod,data);
else
    na=[];
end

%----- Calculate the frequency and amplitude
[f,a]=feval(ifmethod,data,dt);

if ~isempty(na)
   %----- Throw away amplitude from 'ifmethod' and use normalization amplitude
   a=na;
end

%----- Filter the frequency if requested
if nfilter>0
    for i=1:nIMF
        f(:,i)=medianfilter(f(:,i),nfilter);
    end
end

%----- Flip again if data was flipped at the beginning
if flipped
    f=f';
    a=a';
end

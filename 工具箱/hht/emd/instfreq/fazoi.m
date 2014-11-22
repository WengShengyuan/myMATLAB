function [f,a]=faz(data,dt)

% The function FAZ generates a frequency and amplitude using zero-crossing method 
% applied to data(n,k), where n specifies the length of time series, 
% and k is the number of IMFs.
% Non MATLAB Library routine used in the function is: FINDCRITICALPOINTS.
%
% Calling sequence-
% [f,a]=faz(data,dt)
%
% Input-
%	data	- 2-D matrix of IMF components 
%	dt	    - time increment per point
% Output-
%	f	    - 2-D matrix f(n,k) that specifies frequency
%	a	    - 2-D matrix a(n,k) that specifies amplitude
%
% Used by- 
%	FA
% See also-
% 	ZFAPANLS, which in addition to frequency and amplitude, outputs
%	other fields.
 
% Kenneth Arnold (NASA GSFC)	Summer 2003, Modified

%----- Get dimensions
[nPoints, nIMF] = size(data);

%----- Flip data if necessary
flipped=0;
if nPoints < nIMF
    %----- Flip data set
    data = data';
    [nPoints, nIMF] = size(data);
    flipped=1;
end

%----- Inverse dt
idt = 1/dt;

%----- Preallocate arrays
f = zeros(nPoints,nIMF);
a = f;

%----- Process each IMF
for c=1:nIMF
    %----- Find all critical points
    [allX, allY] = quickcriticalpoints(data(:,c));
    nCrit = length(allX);
    
    if nCrit == 1
        % One critical point. If it's an extremum, we can make a guess.
        % This is based on the premise that the wave in question might be
        % an intermittent wave, in which case the first and last points
        % would be zero crossings but are not marked as such.
        if allY(1) == 0, continue, end
        f(:,c) = idt / nPoints;
        a(:,c) = allY(1);
    elseif nCrit < 1
        %----- Too few critical points; keep looping
        continue;
    end
    
    %----- Initialize previous calculated frequencies
    f2prev1 = NaN;
    f4prev1 = NaN;
    f4prev2 = NaN;
    f4prev3 = NaN;

    %----- Initialize previous calculated amplitudes
    a2prev1 = NaN;
    a4prev1 = NaN;
    a4prev2 = NaN;
    a4prev3 = NaN;
    
    for i=1:nCrit-1
        %----- Estimate current frequency
        cx = allX(i);
        f1 = idt / (allX(i+1)-cx);
        a1 = 4*max(abs(allY(i:i+1)));
        npt = 4;
        ftotal = f1;
        atotal = a1;
        
        if i+2<=nCrit
            f2cur = idt / (allX(i+2)-cx);
            range = allY(i:i+2);
            ext = range(range~=0);
            a2cur = 2*mean(abs(ext));
            npt = npt+2;
            ftotal = ftotal+f2cur;
            atotal = atotal+a2cur;
        else
            f2cur=NaN;
            a2cur=NaN;
        end
        
        if i+4<=nCrit
            f4cur = idt / (allX(i+4)-cx);
            range = allY(i:i+4);
            ext = range(range~=0);
            a4cur = mean(abs(ext));
            npt = npt+1;
            ftotal = ftotal+f4cur;
            atotal=atotal+a4cur;
        else
            f4cur=NaN;
            a4cur=NaN;
        end
        
        %----- Add previous points if they are valid
        if ~isnan(f2prev1)
            npt=npt+2;
            ftotal=ftotal+f2prev1;
            atotal=atotal+a2prev1;
        end
        if ~isnan(f4prev1)
            npt=npt+1;
            ftotal=ftotal+f4prev1;
            atotal=atotal+a4prev1;
        end
        if ~isnan(f4prev2)
            npt=npt+1;
            ftotal=ftotal+f4prev2;
            atotal=atotal+a4prev2;
        end
        if ~isnan(f4prev3)
            npt=npt+1;
            ftotal=ftotal+f4prev3;
            atotal=atotal+a4prev3;
        end
        
        f(ceil(allX(i)):floor(allX(i+1)),c) = ftotal/npt;
        a(ceil(allX(i)):floor(allX(i+1)),c) = atotal/npt;
        
        f2prev1=f2cur;
        f4prev3=f4prev2;
        f4prev2=f4prev1;
        f4prev1=f4cur;
        
        a2prev1=a2cur;
        a4prev3=a4prev2;
        a4prev2=a4prev1;
        a4prev1=a4cur;
    end
    
    %----- Fill in ends
    f(1:ceil(allX(1))-1,c) = f(ceil(allX(1)),c);
    f(floor(allX(nCrit))+1:nPoints,c) = f(floor(allX(nCrit)),c);

    a(1:ceil(allX(1))-1,c) = a(ceil(allX(1)),c);
    a(floor(allX(nCrit))+1:nPoints,c) = a(floor(allX(nCrit)),c);
end

%----- Flip again if data was flipped at the beginning
if (flipped)
    f=f';
    a=a';
end

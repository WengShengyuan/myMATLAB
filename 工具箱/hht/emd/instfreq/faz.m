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
 
% Kenneth Arnold (NASA GSFC)	Summer 2003, Rewrote
% Kenneth Arnold (NASA GSFC)    Summer 2004, Modified
%  (use spline to connect known frequency and amplitudes; use accurate
%  critical points method; attempt to process intermittent waves; optimize
%  heavily)

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
    [allX, allY] = findcriticalpoints(data(:,c));
    allY = abs(allY);
    nCrit = length(allX);
    
    if nCrit == 1
        % One critical point. If it's an extremum, we can make a guess.
        % This is based on the premise that the wave in question might be
        % an intermittent wave, in which case the first and last points
        % would be zero crossings but are not marked as such.
        if allY(1) == 0, continue, end
        
        % Try to avoid processing the trend like this.
        if nPoints > 50 & (abs(data(1,c)) > 0.1*abs(allY(1)) | abs(data(end,c)) > 0.1*abs(allY(1)))
            continue;
        end
        
        % Estimate the frequency and amplitude
        f(:,c) = idt / nPoints / 2;
        a(:,c) = allY(1);
        continue;
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
    
    % Preallocate spline control points
    fsx = zeros(nCrit+1,1);
    fsy = fsx;
    asx = fsx;
    asy = fsx;
    
    % keep a flag of whether the current critical point is an extremum
    extFlag = allY(1) ~= 0;
    
    % Loop over critical points
    for i=1:nCrit-1
        %----- Estimate current frequency
        cx = allX(i);
        f1 = idt / (allX(i+1)-cx);
        if extFlag
            a1 = 4*allY(i);
        else
            a1 = 4*allY(i+1);
        end
        npt = 4;
        ftotal = f1;
        atotal = a1;
        
        if i+2<=nCrit
            f2cur = idt / (allX(i+2)-cx);
            if extFlag
                a2cur = allY(i)+allY(i+2);
            else
                a2cur = 2*allY(i+1);
            end
            npt = npt+2;
            ftotal = ftotal+f2cur;
            atotal = atotal+a2cur;
        else
            f2cur=NaN;
            a2cur=NaN;
        end
        
        if i+4<=nCrit
            f4cur = idt / (allX(i+4)-cx);
            if extFlag
                a4cur = (allY(i)+allY(i+2)+allY(i+4))/3;
            else
                a4cur = (allY(i+1)+allY(i+3))/2;
            end
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
        
        fsx(i+1) = .5*(allX(i)+allX(i+1));
        asx(i+1) = fsx(i+1);
        fsy(i+1) = ftotal/npt;
        asy(i+1) = atotal/npt;
        
        f2prev1=f2cur;
        f4prev3=f4prev2;
        f4prev2=f4prev1;
        f4prev1=f4cur;
        
        a2prev1=a2cur;
        a4prev3=a4prev2;
        a4prev2=a4prev1;
        a4prev1=a4cur;
        
        extFlag = ~extFlag;
        % The code below would cause the MATLAB accelerator not to
        % accelerate this inner loop. Enable it if you're having any sort
        % of problem with this function, but it will slow down.
%        if (extFlag && allY(i+1) == 0) || (~extFlag && allY(i+1) ~= 0)
%             error('hht:faNotIMF','A non-IMF was passed to fazsa.');
%         end
    end
    
    %----- Fill in ends
    fsx(1) = 0;
    fsy(1) = fsy(2);
    asx(1) = 0;
    asy(1) = asy(2);
    
    fsx(end) = nPoints+1;
    fsy(end) = fsy(end-1);
    asx(end) = nPoints+1;
    asy(end) = asy(end-1);
    
    % Interpolate
    f(:,c) = spline(fsx, fsy, (1:nPoints)');
    a(:,c) = spline(asx, asy, (1:nPoints)');
end

%----- Flip again if data was flipped at the beginning
if (flipped)
    f=f';
    a=a';
end

function [f,a] = faacos(data, dt)

% The function FAACOS generates an arccosine frequency and amplitude 
% of previously normalized data(n,k), where n is the length of the
% time series and k is the number of IMFs.
% 
% FAACOS finds the frequency by applying
% the arccosine function to the normalized data and
% checking the points where slope of arccosine phase changes.
% Nature of the procedure suggests not to use the function
% to process the residue component.
%
% Calling sequence-
% [f,a] = faacos(data, dt)
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
 
% Kenneth Arnold (NASA GSFC)	Summer 2003, Initial

%----- Get dimensions
[npts,nimf] = size(data);

%----- Flip data if necessary
flipped=0;
if (npts < nimf)
    flipped=1;
    data=data';
    [npts,nimf] = size(data);
end

%----- Input is normalized, so assume that amplitude is always 1
a = ones(npts,nimf);

%----- Mark points that are above 1 as invalid (Not a Number)
data(find(abs(data)>1)) = NaN;

%----- Process each IMF
for c=1:nimf
    %----- Compute "phase" by arccosine
    acphase = acos(data(:,c));
    
    %----- Mark points where slope of arccosine phase changes as invalid
    for i=2:npts-1
        prev = data(i-1,c);
        cur = data(i,c);
        next = data(i+1,c);
        
        if (prev < cur & cur > next) | (prev > cur & cur < next)
            acphase(i) = NaN;
        end
    end
    
   %----- Get phase differential frequency
   acfreq = abs(diff(acphase))/(2*pi*dt);
   
   %----- Mark points with negative frequency as invalid
   acfreq(find(acfreq<0)) = NaN;
   
   %----- Fill in invalid points using a spline
   legit = find(~isnan(acfreq));
   if (length(legit) < npts)
       f(:,c) = spline(legit, acfreq(legit), 1:npts)';
   else
       f(:,c) = acfreq;
   end
end

%----- Flip again if data was flipped at the beginning
if (flipped)
    f=f';
    a=a';
end

function [nf, na, ex, E, N] = nfam5m(data,dt)

% The function NFAM5M calculates the smoothed modified Hilbert frequency and amplitude
% of data(n,k), where n specifies the length of time series,
% and k is the number of IMF components.
% Function processes multiple IMF components.
% Except frequency and amplitude the function returns other fields described below.
% Data is normalized with spline fitting of maxima with the ends fixed.
% Final frequency and amplitude values are smoothed with a 5-point
% median filter.
% Modified Hilbert transform function 'hilbtm()' is used
% to perform a Hilbert transform.
%
% Non MATLAB Library routines used in the function are:
%	EMAX, HILBTM, COPYENDPOINTS.
% Note: NFAM5M processes multiple IMF components.
%
% Calling sequence-
% [nf,na,ex,E,N]=nfam5m(data,dt)
%
% Input-
%	data	- 2-D matrix data(n,k) of IMF components
%	dt	    - sampling period in secondss
% Output-
%	nf	    - 2-D matrix nf(n,k) that specifies the Hilbert frequency in Hz
%	na	    - 2-D matrix na(n,k) that specifies the Hilbert amplitude
%	ex	    - 2-D matrix ex(n,k) that specifies the splined envelope
%	E	    - 2-D matrix E(n,k) that specifies the normalized input data
%	N	    - 2-D matrix N(n,k) that specifies the nonlinearity index
 
% Norden Huang (NASA GSFC)	    June 2, 2002 Initial
% Karin Blank (NASA GSFC)	    April 17, 2003 Modified for multiple IMFs
% Jelena Marshak (NASA GSFC)	Nov. 7, 2003 Modified
%				                (corrected multiple IMF processing)

%----- Flip if orientation isn't correct
if(size(data,1) < size(data,2))
    data = data';
end

%----- Process each IMF component in a loop
for j=1:size(data, 2)
    imf = data(:, j);

    % Get dimensions    
    [n,m] = size(imf); 
    te=1:n; te=te';

    %----- Extract the set of max points and their coordinates
    [mx, tx]=emax(imf);
%   [mx, tx]=eall(imf);
    mx = abs(mx);

    %----- Check and process the data that has extrema    
    if(isempty(mx) | min(imf) > 0) 
        disp(['Data set ', num2str(j), ' skipped. Is not an IMF.']);
    else        
        %----- Fix the ends to prevent wide swaying in spline 
        %----- by adding the te(1) anf te(n) at the same values 
        %----- of the first and last tx and mx.
	%----- KB fix needed to avoid envelope cutting into data
        [beg_x,beg_y,end_x,end_y] = copyendpoints(tx, mx, data(:,j), 1);
        tx = [beg_x'; tx; end_x'];
        mx = [beg_y'; mx; end_y'];
        ex_temp=spline(tx,mx,te);

        %----- Normalize data by splined envelope
        E_temp=imf./ex_temp;

        %----- Apply modified Hilbert transform
        nf_temp=diff(unwrap(angle(hilbtm(E_temp))))./(2*pi*dt);
        nf_temp=[nf_temp;nf_temp(n-1)];
        na_temp=abs(hilbtm(E_temp));
        
        %----- Apply median for every 5 points, 5/4/02
        for i=3:n-2
            nf_temp(i,:)=median(nf_temp(i-2:i+2,:));
            na_temp(i,:)=median(na_temp(i-2:i+2,:));
        end
        
        %----- Compute the Nonlinear Index 
        N(j,:)=((na_temp-1).^2)';
        nf(j,:) = nf_temp';
        na(j,:) = na_temp';
        E(j,:) = E_temp';
        ex(j,:) = ex_temp';
    end
end

%----- Re-constitute na
%  na=na.*ex;

%----- Plot the results:

%plot(te,data,te,ex,te,E,te,nf,te,na,te,N, 'LineWidth', 1.5);
%legend('Data','ex','E','nf','na','N');
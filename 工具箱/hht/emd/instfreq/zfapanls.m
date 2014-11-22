function [p,stdp,f,stdf,a,stda]=zfapanls(data,dt)

% The function ZFAPANLS generates a frequency, amplitude and period using a zero-crossing
% method applied to data(n,k), where n specifies the length of time series,
% and k is the number of IMF components.
%
% Non MATLAB Library routine used in the function is: FINDCRITICALPOINTS.
%
% Calling sequence-
% [p,stdp,f,stdf,a,stda]=zfapanls(data,dt)
%
% Input-
%	data	- 2-D matrix data(n,k) of IMF components
%	dt	    - time increment per point
% Output-
%	p	    - 2-D matrix p(n,k) that specifies period
%	stdp	- 2-D matrix stdp(n,k) that specifies period STDV
%	f	    - 2-D matrix f(n,k) that specifies frequency
%	stdf	- 2-D matrix stdf(n,k) that specifies frequency STDV
%	a	    - 2-D matrix a(n,k) that specifies amplitude
%	stda	- 2-D matrix stda(n,k) that specifies amplitude STDV
 
% Kenneth Arnold (NASA GSFC)	Summer 2003, Modified
% Steven R. Long (NASA WFF)	    Oct. 8, 2003, Added period

%----- Get dimensions  
[nPoints, nIMF] = size(data);

%----- Flip data if necessary
flipped=0;
if nPoints < nIMF
    %flip data set
    data = data';
    [nPoints, nIMF] = size(data);
    flipped=1;
end

%----- Inverse dt
idt = 1/dt;

%----- Initialize arrays to zeros
f = zeros(nPoints,nIMF);
stdf = f;
p = f;
stdp = f;
a = f;
stda = f;

%----- Process each IMF
for c=1:nIMF
    %----- Find all critical points
    [allX, allY] = findcriticalpoints(data(:,c));
    nCrit = length(allX);
    
    if nCrit <= 1
        %----- Too few critical points; keep looping
        continue;
    end

    %----- Initialize previous calculated periods
    p2prev1 = NaN;
    p4prev1 = NaN;
    p4prev2 = NaN;
    p4prev3 = NaN;
    
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
        p1 = 1/f1;
        a1 = 4*max(abs(allY(i:i+1)));
        npt = 4;
        ftotal = f1;
        ptotal = p1;
        atotal = a1;
        
        if i+2<=nCrit
            f2cur = idt / (allX(i+2)-cx);
            p2cur = 1/f2cur;
            range = allY(i:i+2);
            ext = range(range~=0);
            a2cur = 2*mean(abs(ext));
            npt = npt+2;
            ftotal = ftotal+f2cur;
            ptotal = ptotal+p2cur;
            atotal = atotal+a2cur;
        else
            f2cur=NaN;
				p2cur=NaN;
        end
        
        if i+4<=nCrit
            f4cur = idt / (allX(i+4)-cx);
				p4cur = 1/f4cur;
            range = allY(i:i+4);
            ext = range(range~=0);
            a4cur = mean(abs(ext));
            npt = npt+1;
            ftotal = ftotal+f4cur;
				ptotal = ptotal+p4cur;
            atotal=atotal+a4cur;
        else
            f4cur=NaN;
            p4cur=NaN;
        end
        
        %----- Add previous points if they are valid
        if ~isnan(f2prev1)
            npt=npt+2;
            ftotal=ftotal+f2prev1;
            ptotal=ptotal+p2prev1;
            atotal=atotal+a2prev1;
        end
        if ~isnan(f4prev1)
            npt=npt+1;
            ftotal=ftotal+f4prev1;
				ptotal=ptotal+p4prev1;
            atotal=atotal+a4prev1;
        end
        if ~isnan(f4prev2)
            npt=npt+1;
            ftotal=ftotal+f4prev2;
            ptotal=ptotal+p4prev2;
            atotal=atotal+a4prev2;
        end
        if ~isnan(f4prev3)
            npt=npt+1;
            ftotal=ftotal+f4prev3;
				ptotal=ptotal+p4prev3;
            atotal=atotal+a4prev3;
        end
        
        curF = ftotal / npt;
        curP = ptotal / npt;
        curA = atotal / npt;
        
        f(ceil(allX(i)):floor(allX(i+1)),c) = curF;
        p(ceil(allX(i)):floor(allX(i+1)),c) = curP;
        a(ceil(allX(i)):floor(allX(i+1)),c) = curA;
        
        %----- Calculate stdf and stda
        fdtotal = 4*(curF-f1/4).^2;
        pdtotal = 4*(curP-p1/4).^2;
        adtotal = 4*(curA-a1/4).^2;
        npt = 4;
        
        if ~isnan(f2cur)
            npt=npt+2;
            fdtotal = fdtotal+2*(curF-f2cur/2).^2;
            pdtotal = pdtotal+2*(curP-p2cur/2).^2;
            adtotal = adtotal+2*(curA-a2cur/2).^2;
        end
        if ~isnan(f2prev1)
            npt=npt+2;
            fdtotal = fdtotal+2*(curF-f2prev1/2).^2;
            pdtotal = pdtotal+2*(curP-p2prev1/2).^2;
            adtotal = adtotal+2*(curA-a2prev1/2).^2;
        end
        if ~isnan(f4prev1)
            npt=npt+1;
            fdtotal = fdtotal+(curF-f4prev1).^2;
            pdtotal = pdtotal+(curP-p4prev1).^2;
            adtotal = adtotal+(curA-a4prev1).^2;
        end
        if ~isnan(f4prev2)
            npt=npt+1;
            fdtotal = fdtotal+(curF-f4prev2).^2;
            pdtotal = pdtotal+(curP-p4prev2).^2;
            adtotal = adtotal+(curA-a4prev2).^2;
        end
        if ~isnan(f4prev3)
            npt=npt+1;
            fdtotal = fdtotal+(curF-f4prev3).^2;
            pdtotal = pdtotal+(curP-p4prev3).^2;
            adtotal = adtotal+(curA-a4prev3).^2;
        end
        if ~isnan(f4cur)
            npt=npt+1;
            fdtotal = fdtotal+(curF-f4cur).^2;
            pdtotal = pdtotal+(curP-p4cur).^2;
            adtotal = adtotal+(curA-a4cur).^2;
        end
        
        stdf(ceil(allX(i)):floor(allX(i+1)),c) = sqrt(fdtotal/npt);
        stdp(ceil(allX(i)):floor(allX(i+1)),c) = sqrt(pdtotal/npt);
        stda(ceil(allX(i)):floor(allX(i+1)),c) = sqrt(adtotal/npt);
        
        f2prev1=f2cur;
        f4prev3=f4prev2;
        f4prev2=f4prev1;
        f4prev1=f4cur;
        
        p2prev1=p2cur;
        p4prev3=p4prev2;
        p4prev2=p4prev1;
        p4prev1=p4cur;
        
        a2prev1=a2cur;
        a4prev3=a4prev2;
        a4prev2=a4prev1;
        a4prev1=a4cur;
    end
    
    %----- Fill in ends
    f(1:ceil(allX(1))-1,c) = f(ceil(allX(1)),c);
    f(floor(allX(nCrit))+1:nPoints,c) = f(floor(allX(nCrit)),c);

    p(1:ceil(allX(1))-1,c) = p(ceil(allX(1)),c);
    p(floor(allX(nCrit))+1:nPoints,c) = p(floor(allX(nCrit)),c);

    stdf(1:ceil(allX(1))-1,c) = stdf(ceil(allX(1)),c);
    stdf(floor(allX(nCrit))+1:nPoints,c) = stdf(floor(allX(nCrit)),c);

    stdp(1:ceil(allX(1))-1,c) = stdp(ceil(allX(1)),c);
    stdp(floor(allX(nCrit))+1:nPoints,c) = stdp(floor(allX(nCrit)),c);

    a(1:ceil(allX(1))-1,c) = a(ceil(allX(1)),c);
    a(floor(allX(nCrit))+1:nPoints,c) = a(floor(allX(nCrit)),c);

    stda(1:ceil(allX(1))-1,c) = stda(ceil(allX(1)),c);
    stda(floor(allX(nCrit))+1:nPoints,c) = stda(floor(allX(nCrit)),c);
end

%----- Flip again if data was flipped at the beginning
if flipped
    f=f';
    p=p';
    stdf=stdf';
    stdp=stdp';
    a=a';
    stda=stda';
end

%----- Plot
te=[1:nPoints];
plot(te,p,te,stdp,te,f,te,stdf,te,a,te,stda, 'LineWidth', 1.5);
legend('Period','Period STD','Freq','Freq STD','AMP','AMP STD');

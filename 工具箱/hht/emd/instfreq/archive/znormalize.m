function [data,a]=znormalize(data)

[nPoints, nIMF] = size(data);

flipped=0;
if nPoints < nIMF
    %flip data set
    data = data';
    [nPoints, nIMF] = size(data);
    flipped=1;
end

% preallocate arrays
a = zeros(nPoints,nIMF);

for c=1:nIMF
    % find all critical points
    [allX, allY] = find_critical_points(data(:,c));
    nCrit = length(allX);
    
    if nCrit <= 1
        % too few critical points; keep looping
        continue;
    end
    
    % previous calculated amplitudes
    a2prev1 = NaN;
    a4prev1 = NaN;
    a4prev2 = NaN;
    a4prev3 = NaN;
    
    for i=1:nCrit-1
        cx = allX(i);
        a1 = 4*max(abs(allY(i:i+1)));
        npt = 4;
        atotal = a1;
        
        if i+2<=nCrit
            range = allY(i:i+2);
            ext = range(range~=0);
            a2cur = 2*mean(abs(ext));
            npt = npt+2;
            atotal = atotal+a2cur;
        else
           af2cur=NaN;
        end
        
        if i+4<=nCrit
            range = allY(i:i+4);
            ext = range(range~=0);
            a4cur = mean(abs(ext));
            npt = npt+1;
            atotal=atotal+a4cur;
        else
            a4cur=NaN;
        end
        
        % if previous points are valid, add them in also
        if ~isnan(a2prev1)
            npt=npt+2;
            atotal=atotal+a2prev1;
        end
        if ~isnan(a4prev1)
            npt=npt+1;
            atotal=atotal+a4prev1;
        end
        if ~isnan(a4prev2)
            npt=npt+1;
            atotal=atotal+a4prev2;
        end
        if ~isnan(a4prev3)
            npt=npt+1;
            atotal=atotal+a4prev3;
        end
        
        a(ceil(allX(i)):floor(allX(i+1)),c) = atotal/npt;
        
        a2prev1=a2cur;
        a4prev3=a4prev2;
        a4prev2=a4prev1;
        a4prev1=a4cur;
    end
    
    % fill in ends
    a(1:ceil(allX(1))-1,c) = a(ceil(allX(1)),c);
    a(floor(allX(nCrit))+1:nPoints,c) = a(floor(allX(nCrit)),c);
end

if (flipped)
    a=a';
end
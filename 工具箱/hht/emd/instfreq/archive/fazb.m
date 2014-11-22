function [f, a] = fazb(datay, deltat);
%    [f, a] = fazb(datay, deltat):
%
%    Function to generate a zero-crossing (and extrema) frequency
%    and amplitude of datay(k,n),
%    where k is number of IMFs, and n specifies the length of time series.
%
%    Input-
%	datay	- 2-D matrix datay(k,n) of IMF components
%	deltat	- the timescale of data
%    Output-
%	f	- 2-D matrix f(k,n) that specifies frequency
%	a	- 2-D matrix a(k,n) that specifies amplitude
%
%    Karin Blank (NASA GSFC)	March 11, 2003 Initial
%    Karin Blank (NASA GSFC)	March 27, 2003 Modified
%    Kenneth Arnold (NASA GSFC)	August 3, 2003 Modified
%    Jelena Marshak (NASA GSFC)	December 30, 2003 Edited
%
%    Notes-
%    Non MATLAB Library routines used in the function are:
%	'findcriticalpoints.m'.
%    The function is a modified version of 'zfab.m'.
%    Not used.
%
%    Temporary remarks-
%    Changed the function name, was 
%    'faz()' for the code named as 'fazb.m'.
%    Removed '_' from parameter names.
%    Replaced 'find_critical_points' by 'findcriticalpoints'. 

%----- Get dimensions
[num_imfs, num_pnts] = size(datay);

%----- Flip data if necessary
flipped=0;
if(num_pnts < num_imfs)
    %----- Flip data set
    datay = datay';
    [num_imfs, num_pnts] = size(datay);
    flipped=1;
end

f = zeros(num_imfs, num_pnts);
a = f;

%----- Process each IMF
%tm=0
for i=1:num_imfs
    %    emp = cputime;
    %----- Get the critical points
    [all_x, all_y] = findcriticalpoints(datay(i,:));
    %    tm = tm+cputime-emp;
    
    if(length(all_x) <= 4)
        continue;
    end
    
    num_crit = length(all_x);
    
    %----- Calculate f values
    for j=1:length(all_x)-7
        
        %----- Calculate f1
        f1 = 1 / (4 * deltat * (all_x(j+1) - all_x(j)));
        
        %----- Calculate f2
        f2(1) = 1 / (2 * deltat * (all_x(j+2) - all_x(j)));
        f2(2) = 1 / (2 * deltat * (all_x(j+3) - all_x(j+1)));
        
        %----- Calculate f4
        f4(1) = 1 / ((all_x(j+4) - all_x(j)) * deltat);
        f4(2) = 1 / ((all_x(j+5) - all_x(j+1)) * deltat);
        f4(3) = 1 / ((all_x(j+6) - all_x(j+2)) * deltat);
        f4(4) = 1 / ((all_x(j+7) - all_x(j+3)) * deltat);
        
        %----- Calculate frequency (f)
        temp = (4*f1 + 2*(f2(1) + f2(2)) + (f4(1) + f4(2) + f4(3) + f4(4)))/12;
        
        if(j==1)
            f(i,1:floor(all_x(j+1)-1)) = temp;
        else         
            f(i,floor(all_x(j)):floor(all_x(j+1)-1)) = temp;
        end
        
    end
    
    if(length(all_x)<=7)
        j=1;
    end
    
    %----- Calculate f for length(all_x)-7:length(all_x)-3
    for j=j:length(all_x)-4
        %----- Calculate f1
        f1 = 1 / (4 * deltat * (all_x(j+1) - all_x(j)));
        
        %----- Calculate f2
        f2(1) = 1 / (2 * deltat * (all_x(j+2) - all_x(j)));
        f2(2) = 1 / (2 * deltat * (all_x(j+4) - all_x(j+2)));
        
        %----- Use revised f calculation
        temp = (2*f1 + f2(1) + f2(2))/4;
        
        if(j==1)
            f(i,1:floor(all_x(j+1)-1)) = temp;
        else
            f(i,floor(all_x(j)):floor(all_x(j+1)-1)) = temp;
        end
    end
    
    %----- Calculate f for length(all_x)-3:length(all_x)-1
    for j=j:length(all_x)-1
        temp = 1 / (4 * deltat * (all_x(j+1) - all_x(j)));
        
        if(j==1)
            f(i,1:floor(all_x(j+1)-1)) = temp;
        else
            f(i,floor(all_x(j)):floor(all_x(j+1)-1)) = temp;
        end
    end
    
    %----- Make sure calculation starts at an extrema
    if(all_y(1) == 0)
        all_y = all_y(2:end);
        all_x = all_x(2:end);
    end
    
    for j=1:2:length(all_y)-1
        
        %----- Calculate mean amplitude (a)
        if(j+3 < length(all_y))
            %----- Next 2 extrema (find elminates x-crossing values)
            [p, m, k] = find(all_y(j:j+3));
        else
            [p, m, k] = find(all_y(j:end));
        end
        temp1 = mean(abs(k));
        
        %----- Make sure non-negative values are used
        if(j == 1)
            a(i,1:floor(all_x(j+2))-1) = temp1;
        elseif((j+2) > length(all_y))
            a(i,floor(all_x(j)):length(datay)) = temp1;
        else
            a(i,floor(all_x(j)):floor(all_x(j+2))-1) = temp1;
        end
        
    end
    
    %----- Propogate last points if values are not quite size of datay 
    f(i,ceil(all_x(length(all_x))):length(datay)) = f(i,ceil(all_x(length(all_x)))-1);
    a(i,ceil(all_x(length(all_x))):length(datay)) = a(i,ceil(all_x(length(all_x)))-1);
end

%----- Flip again if data was flipped at the beginning
if (flipped)
    f=f';
    a=a';
end

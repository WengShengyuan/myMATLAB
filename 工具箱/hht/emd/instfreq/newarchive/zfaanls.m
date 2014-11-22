function [f, stdf , a, rmsa] = zfaanls(datay, deltat)

% The function ZFAANLS generates a frequency and amplitude using a zero-crossing
% method applied to datay(k,n),
% where k is number of IMFs, and n specifies the length of time series.
% Additionally ZFAANLS returns a standard deviation of frequency 
% and root mean square of amplitude of datay(k,n). 
% 
% Non MATLAB Library routine used in the function is: FINDCRITICALPOINTS.
%
% Note: input data dimensions are reversed compared to other routines that
% calculate frequency and amplitude: the 1st dimension specifies the number
% of IMF components, and the 2nd dimension - the number of data points.
%
% Calling sequence-
% [f, stdf, a, rmsa] = zfaanls(datay, deltat)
%
% Input-
%	datay	- 2-D matrix datay(k,n) of IMF components
%	deltat	- the timescale of data
% Output-
%	f	    - 2-D matrix f(k,n) that specifies frequency
%	stdf	- 2-D matrix stdf(k,n) that specifies frequency STDV
%	a	    - 2-D matrix a(k,n) that specifies amplitude
%	rmsa	- 2-D matrix rmsa(k,n) that specifies amplitude RMS
 
% Karin Blank (NASA GSFC)	    March 11, 2003 Initial
% Karin Blank (NASA GSFC)	    March 27, 2003 Modified
% Jelena Marshak (NASA GSFC)	November 19, 2003 Modified
%	(Corrected for number of critical points between 4 and 8.)

%----- Get dimensions
[num_imfs, num_pnts] = size(datay);

%----- Flip data if necessary
flipped=0;
if(num_pnts < num_imfs)
    %flip data set
    datay = datay';
    [num_imfs, num_pnts] = size(datay);
    flipped=1;
end

%----- Process each IMF
%tm=0
for i=1:num_imfs
%    emp = cputime;
    %----- Get the critical points
    [all_x, all_y] = findcriticalpoints(datay(i,:));
%    tm = tm+cputime-emp;
    
    %----- Zero arrays and stop
    if(length(all_x) <= 4)
        f(i:num_imfs,1:num_pnts) =  zeros(num_imfs-i+1,num_pnts);
        stdf(i:num_imfs, 1:num_pnts) =  zeros(num_imfs-i+1,num_pnts);
        a(i:num_imfs, 1:num_pnts) =  zeros(num_imfs-i+1,num_pnts); 
        rmsa(i:num_imfs, 1:num_pnts) = zeros(num_imfs-i+1,num_pnts);
        break;
    end
    
    num_crit = length(all_x);
    
    %----- Initialize values
    f_tmp = [];
    stdf_tmp = [];
    a_tmp = [];
    rmsa_tmp = [];
    
    %----- Calculate f values
    if(length(all_x) > 7)
      for j=1:length(all_x)-7
             
        %----- Calculate f1
        f1 = 1 / (4 * deltat * (all_x(j+1) - all_x(j)));
        
        %----- Calculate f2
        f2(1) = 1 / (2 * deltat * (all_x(j+2) - all_x(j)));
        f2(2) = 1 / (2 * deltat * (all_x(j+4) - all_x(j+2)));
        
        %----- Calculate f4
        f4(1) = 1 / ((all_x(j+4) - all_x(j)) * deltat);
        f4(2) = 1 / ((all_x(j+5) - all_x(j+1)) * deltat);
        f4(3) = 1 / ((all_x(j+6) - all_x(j+2)) * deltat);
        f4(4) = 1 / ((all_x(j+7) - all_x(j+3)) * deltat);
        
        %----- Calculate frequency (f)
        tmp = (4*f1 + 2*(f2(1) + f2(2)) + (f4(1) + f4(2) + f4(3) + f4(4)))/12;
              
        tmp_std = sqrt( (4*(f1-tmp)^2 + 2*(f2(1)-tmp)^2 + 2*(f2(2)-tmp)^2 + (tmp - f4(1))^2 + (tmp - f4(2))^2 + (tmp - f4(3))^2 + (tmp - f4(4))^2)/12);
        
        if(j==1)
            f_tmp(1:floor(all_x(j+1)-1)) = tmp;
            stdf_tmp(1:floor(all_x(j+1)-1)) = tmp_std;
        else         
            f_tmp(floor(all_x(j)):floor(all_x(j+1)-1)) = tmp;
            stdf_tmp(floor(all_x(j)):floor(all_x(j+1)-1)) = tmp_std;
        end
        
     end

    else
     j=1;
    end
    
    %----- Calculate f for length(all_x)-7:length(all_x)-3
    for j=j:length(all_x)-4
        %----- Calculate f1
        f1 = 1 / (4 * deltat * (all_x(j+1) - all_x(j)));
        
        %----- Calculate f2
        f2(1) = 1 / (2 * deltat * (all_x(j+2) - all_x(j)));
        f2(2) = 1 / (2 * deltat * (all_x(j+4) - all_x(j+2)));
        
        %-----Use revised f calculation
        tmp = (2*f1 + f2(1) + f2(2))/4;
        tmp_std = sqrt( (2*(f1-tmp)^2 + (f2(1)-tmp)^2 + (f2(2)-tmp)^2)/4);
        
        if(j==1)
            f_tmp(1:floor(all_x(j+1)-1)) = tmp;
            stdf_tmp(1:floor(all_x(j+1)-1)) = tmp_std;
        else
            f_tmp(floor(all_x(j)):floor(all_x(j+1)-1)) = tmp;
            stdf_tmp(floor(all_x(j)):floor(all_x(j+1)-1)) = tmp_std;
        end
    end
    
    fhold = stdf_tmp(end);
    %----- Calculate f for length(all_x)-3:length(all_x)-1
    for j=j:length(all_x)-1
        tmp = 1 / (4 * deltat * (all_x(j+1) - all_x(j)));
        
        fhold = [fhold, tmp];
        
        if(j==1)
            f_tmp(1:floor(all_x(j+1)-1)) = tmp;
            stdf_tmp(1:floor(all_x(j+1)-1)) = std(fhold);
        else
            f_tmp(floor(all_x(j)):floor(all_x(j+1)-1)) = tmp;
            stdf_tmp(floor(all_x(j)):floor(all_x(j+1)-1)) = std(fhold);
        end
        
        fhold = tmp;
    end
    
    %-----Make sure calculation starts at an extrema
    if(all_y(1) == 0)
        all_y = all_y(2:end);
        all_x = all_x(2:end);
    end

    for j=1:2:length(all_y)-1

        %----- Calculate mean amplitude (a)
        if(j+3 < length(all_y))
            [p, m, k] = find(all_y(j:j+3)); %next 2 extrema (find elminates x-crossing values)
        else
            [p, m, k] = find(all_y(j:end));
        end
        tmp1 = mean(abs(k));
 
        %----- Calculate root mean square of a values
        tmp2 = norm(abs(k))/2;   
        

        %----- Make sure non-negative values are used
        if(j == 1)
           a_tmp(1:floor(all_x(j+2))-1) = tmp1;
           rmsa_tmp(1:floor(all_x(j+2))-1) = tmp2;
       elseif((j+2) > length(all_y))
           a_tmp(floor(all_x(j)):length(datay)) = tmp1;
           rmsa_tmp(floor(all_x(j)):length(datay)) = tmp2;
       else
           a_tmp(floor(all_x(j)):floor(all_x(j+2))-1) = tmp1;
           rmsa_tmp(floor(all_x(j)):floor(all_x(j+2))-1) = tmp2;
       end
           
    end
    
    %----- Propogate last points if values are not quite size of datay 
    f_tmp(end:length(datay)) = f_tmp(end);
    stdf_tmp(end:length(datay)) = stdf_tmp(end);
    a_tmp(end:length(datay)) = a_tmp(end);
    rmsa_tmp(end:length(datay)) = rmsa_tmp(end);


    %----- Tack on array of values calculated for this IMF
    %----- to returning arrays
    f(i,1:length(datay)) = f_tmp(1:length(datay)); 
    stdf(i, 1:length(datay)) = stdf_tmp(1:length(datay)); 
    a(i, 1:length(datay)) = a_tmp(1:length(datay)); 
    rmsa(i, 1:length(datay)) = rmsa_tmp(1:length(datay));
    
   
end

%----- Flip again if data was flipped at the beginning
if (flipped)
    f=f';
    stdf=stdf';
    a=a';
    rmsa=rmsa';
end

%----- Plot
te=[1:num_pnts];
plot(te,f,te,stdf,te,a,te,rmsa, 'LineWidth', 1.5);
legend('Freq','Freq STD','AMP','AMP RMS');

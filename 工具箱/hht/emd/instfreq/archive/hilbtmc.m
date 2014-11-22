function h=hilbtmc(x)
%
%    h=hilbtmc(x):
%
%    Function to perform an improved Hilbert transform on data x(n,k)),
%    where n specifies the length of time series, and 
%    k - the number of IMF components.
%    The end effect is eliminated by extension of data. 
%
%    Input-
%	x	- 2-D matrix x(n,k) of IMF components
%    Output-
%	h	- 2-D matrix h(n,k) of improved Hilbert transform
%		  with the end effect eliminated by extension of data
%
%    Z. Shen (JHU)		Jan. 1996   Initial
%    D. Xiang (JHU)		April 4, 2002  Modified
%    K. Blank (NASA GSFC)	April 18, 2003 Modified
%    J. Marshak (NASA GSFC)	Nov. 7, 2003 Edited
%
%    Temporary remarks -
%    Changed the function name,
%    was  'hilbtm()' for the code named as 'hilbt_m.m'.
%    The function is the latest version of the modified Hilbert transform
%    function received from Karin Blank.

%----- Get dimensions
[n,k]=size(x);

%----- Process each IMF component
for j=1:k
    zz= [];

    %----- Modified code to correctly detect extrema -KB
    n_mx = 1; n_mn = 1;
    flagmax=0; flagmin=0;
    for i=2:n-1
        %----- Find local maximum
        if ((x(i) > x(i-1)) & (flagmax == 0))
            flagmax = 1;
            Xmax = i;
        end    
        if((x(i) < x(i+1)) & (flagmax == 1))
            flagmax = 0;
        end
        if((x(i) > x(i+1)) & (flagmax == 1))
            flagmax = 0;
            n_mx = Xmax;
        end
        
        %---- Find local minimum
        if((x(i) < x(i-1)) & (flagmin == 0))
            flagmin = 1;
            Xmin = i;
        end
        if((x(i) > x(i+1)) & (flagmin == 1))
            flagmin = 0;
        end
        if((x(i) < x(i+1)) & (flagmin == 1))
            flagmin = 0;
            
            n_mn = Xmin;
        end 
        
        if(x(n_mn) < 0 & x(n_mx) > 0) & (n_mn > 1 & n_mx > 1)
	    %----- 2 extrema found and they are across the zero crossing
            break;
        end
    end
    %----- End of extrema detection
    
    if n_mn<n_mx,
        first = n_mn;
        second = n_mx;
    else
        first = n_mx;
        second = n_mn;
    end
    
    %----- Get all y values between min and max extrema
    zz=x(first:second,j);
    %----- Get length of zz
    mm=length(zz);
    %----- Calculate the number of times to copy artificial wave
    ia=fix(first/(2*(mm-1)))+1;
    %----- DX, modify constant from 1 to 2. Do it at least twice
    iaa=max(ia,2);
    %----- Reverse all the y values between the min and max extrema 
    zz1=flipud(zz); %zz1 is zz
    
    if n_mn<n_mx
        x1=zz1; %copy those values to x1
    else
        x1=[zz;zz1(2:mm)];
    end
    for jj=1:iaa,
        x1=[x1;zz(2:mm);zz1(2:mm)];  % copy the artificial wave 2 times
    end
    %----- DX, find the first zero-cross and the slope
    r=length(x1);
    for kk=1:r-1
        if((x1(kk,j)*x1(kk+1,j))<=0)
            if(abs(x1(kk,j)) > abs(x1(kk+1,j)))
                n0=kk; %found zero crossing
            else
                n0=kk+1; %found zero crossing
            end
            s0=x1(kk+1,j)-x1(kk,j); %calculate the slope
            break;
        end
    end
    %----- Copy all artificial wave values from zero crossing to end
    x1=x1(n0:r,j); 
    %----- Attach actual y values from the minimum extrema
    %----- to the end of the dataset
    x1=[x1;x(first+1:n,j)];
    sz=length(x1); %length of x1
    np1=sz-n; %length of artificial wave portion of x1

 

    %---------------------Treat the tail----------------------------

    %----- Modified code to correctly detect extrema -KB
    n_mx = 1; n_mn = 1;
    flagmax=0; flagmin=0;
    x_flip = fliplr(x1');
    for i=2:sz-1
        %----- Find local maximum
        if ((x_flip(i) > x_flip(i-1)) & (flagmax == 0))
            flagmax = 1;
            Xmax = sz-i;
        end    
        if((x_flip(i) < x_flip(i+1)) & (flagmax == 1))
            flagmax = 0;
        end
        if((x_flip(i) > x_flip(i+1)) & (flagmax == 1))
            flagmax = 0;
            n_mx = Xmax;
        end
        
        %----- Find local minimum
        if((x_flip(i) < x_flip(i-1)) & (flagmin == 0))
            flagmin = 1;
            Xmin = sz-i;
        end
        if((x_flip(i) > x_flip(i+1)) & (flagmin == 1))
            flagmin = 0;
        end
        if((x_flip(i) < x_flip(i+1)) & (flagmin == 1))
            flagmin = 0;
            
            n_mn = Xmin;
        end 
        
        if(x_flip(sz-n_mn) < 0 & x_flip(sz-n_mx) > 0) & (n_mn > 1 & n_mx > 1)
            %----- 2 extrema found and they are across the zero crossing
            break;
        end
    end
    clear x_flip;
    %----- End extrema detection

    if n_mn<n_mx
        first = n_mn;
        second = n_mx;
    else
        first = n_mx;
        second = n_mn;
    end
    %----- Use all y values between xmin and xmax
    zz=x1(first:second);
    mm=length(zz);
    %----- Reverse order y values 
    zz1=flipud(zz);
    %----- Calculate the number of copies of artificial wave to make
    ia=fix((sz-second)/(2*(mm-1)))+1;
     %----- DX, modify constant from 1 to 2. At least 2
    iaa=max(ia,2);
    
    if(n_mn< n_mx)
         %----- Attach initial wave segment       
        x1=[x1(1:second);zz1(2:mm)];
        for jj=1:iaa
             %----- Copiy artificial waves and append them to x1
            x1=[x1;zz(2:mm);zz1(2:mm)];
        end
         %----- Attaches last wave segment
        x1=[x1;zz(2:mm-1)];
    else
        x1=x1(1:second);
        for jj=1:iaa
            %----- Copy artificial waves and append them to x1
            x1=[x1;zz1(2:mm);zz(2:mm)];
        end
         %----- Attach last wave segment       
        x1=[x1;zz1(2:mm-1)];
    end
    


    
    %----- DX, find the first zero-cross and the slope
    r = length(x1);
    for k=1:r-1
        kk=r-k+1;
        if((x1(kk,j)*x1(kk-1,j))<=0)
            if(abs(x1(kk,j)) > abs(x1(kk-1,j)))
                n0=kk;
            else
                n0=kk-1;
            end
            
            if(((x1(kk,j)-x1(kk-1,j))*s0)>0)   %same sign as s0
                break;
            end
        end
    end
    x1=x1(1:n0,j);

        %----- Calculate hilbert transform
	x1=hilbert(x1);
    if ((np1+n-1)<=n0)
            %----- Truncate artificial elements of dataset
	    x(:,j)=x1(np1:np1+n-1);
    else
        np2=n0-np1;
        x(1:np2,j)=x1(np1:n0-1);
    end
end
h=x;
clear x

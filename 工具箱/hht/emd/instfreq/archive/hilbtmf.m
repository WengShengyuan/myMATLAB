function h=hilbtmf(x)
%
%   h=hilbtmf(x):
%    Function to perform an improved Hilbert transform on data x(n,k),
%    where n specifies the length of time series, and 
%    k - the number of IMF components.
%    The end effect is eliminated by extension of data by the wave, 
%    which is calculated from the data points found between two extrema
%    across the zero crossing.
%    If the wave is not found (as in residue) the data is not extended.
%    The function applies smoothing the input data before processing.
%
%    Input-
%	x	- 2-D matrix x(n,k) of IMF components
%    Output-
%	h	- 2-D matrix h(n,k) of improved Hilbert transform
%
%    Z. Shen (JHU)		Jan. 1996   Initial
%    D. XIANG (JHU)		April 4, 2002 Modified 
%	(Extended both ends with 2 waves ending at zero crossing,
%        and both ends with the same slope.)
%    D. Xiang (JHU)		May 18, 2002 Modified
%	(Added smoothing to overcome step function problem.
%        Added handling of the no wave situation.)
%    J.Marshak(NASA GSFC)	Jan.16, 2004 Modified and edited
%	(Replaced 'break' with 'continue' if no wave is found.)
%
%    Temporary remarks -
%	The procedure stops if no wave is found for the IMF:
%       the IMFs that follow will not be processed and return the 
%	original data. It is the assumption that only one IMF 
%	(the last one) can have no detectable extrema (is the residue).
%       The suggestion is to use 'continue' instead of 'break' in order
%	to pass the control to the next available IMF component or 
%	stop if there are none.

%----- Get dimensions
[n,kpt]=size(x);

%----- Use smoothing of x for n_mx and n_mn search 
xx=zeros(n,kpt);
filtr=fir1(8,.1);
for j=1:kpt
   xx(:,j)=filtfilt(filtr,1,x(:,j));
end

%----- Process each IMF component
for j=1:kpt
    %-------------------Treat the head ----------------------------------
    indx1=0; indx2=0;
    n_mx=-1;
    n_mn=-1;
    j2=2;  
    while j2<=n-1 ,    
        if (xx(j2-1,j)<xx(j2,j))&(xx(j2,j)>=xx(j2+1,j))	% max point
            n_mx=j2;
            x_mx=xx(j2,j);
            indx1=1;
        elseif (xx(j2-1,j)>xx(j2,j))&(xx(j2,j)<=xx(j2+1,j)) % min point
            n_mn=j2;
            x_mn=xx(j2,j);
            indx2=1;
        end
        if indx1>=.9 & indx2>=.9
            break
        end
        j2=j2+1;
     end
    
    if (n_mx==-1) | (n_mn==-1)
        %----- Do Hilbert transform directly if no max or min 
        x(:,j)=hilbert(x(:,j));
        continue;
    elseif n_mn<n_mx,
	zz=x(n_mn:n_mx,j);
	mm1=size(zz);mm=mm1(1);
	ia=fix(n_mn/(2*(mm-1)))+1;
	iaa=max(ia,2); %DX, modify constant from 1 to 2.
	zz1=flipud(zz);
	x1=zz1;
	for jj=1:iaa,
	  x1=[x1;zz(2:mm);zz1(2:mm)];
	end
        %----- Find the first zero-crossing and the slope -DX
        [r,c]=size(x1);
        for kk=1:r-1
          if((x1(kk)*x1(kk+1))<=0)
            if(abs(x1(kk)) > abs(x1(kk+1)))
               n0=kk;
            else
               n0=kk+1;
            end
            s0=x1(kk+1)-x1(kk);
            break;
          end
        end
        x1=x1(n0:r);
      
        x1=[x1;x(n_mn+1:n,j)];
	sz=max(size(x1));
	np1=sz-n;
    else
	zz=x(n_mx:n_mn,j);
	mm1=size(zz);mm=mm1(1);
        ia=fix(n_mx/(2*(mm-1)))+1;
	iaa=max(ia,2); %DX, modify constant from 1 to 2.
	zz1=flipud(zz);
        x1=[zz;zz1(2:mm)];
	for jj=1:iaa,
	  x1=[x1;zz(2:mm);zz1(2:mm)];
        end  
        %----- Find the first zero-crossing and the slope -DX
        [r,c]=size(x1);
        for kk=1:r-1
            if((x1(kk)*x1(kk+1))<=0)
               if(abs(x1(kk)) > abs(x1(kk+1)))
                  n0=kk;
               else
                  n0=kk+1;
               end
               s0=x1(kk+1)-x1(kk);
               break;
            end
        end
        x1=x1(n0:r);
	x1=[x1;x(n_mx+1:n,j)];
	sz=max(size(x1));
	np1=sz-n;
    end

    %---------------------Treat the tail---------------------------- 
    j2=n-1;
    indx1=0; indx2=0;	
    while j2>=2 ,
        if (xx(j2-1,j)<xx(j2,j))&(xx(j2,j)>=xx(j2+1,j))	% max point
            n_mx=j2;
            x_mx=xx(j2,j);
            indx1=1;
        elseif (xx(j2-1,j)>=xx(j2,j))&(xx(j2,j)<xx(j2+1,j)) % min point
            n_mn=j2;
            x_mn=xx(j2,j);
            indx2=1;
        end
        if indx1>=.9 & indx2>=.9
            break
        end
        j2=j2-1;
    end
 
    n_mn=n_mn+np1;
    n_mx=n_mx+np1;
    
    if n_mn<n_mx,
	zz=x1(n_mn:n_mx);
	mm=max(size(zz));
	zz1=flipud(zz);	
	ia=fix((sz-n_mx)/(2*(mm-1)))+1;
	iaa=max(ia,2); %DX, modify constant from 1 to 2.
	iaa1=iaa*2;	
	x1=[x1(1:n_mx);zz1(2:mm)];
	for jj=1:iaa
	   x1=[x1;zz(2:mm);zz1(2:mm)];
	end
        x1=[x1;zz(2:mm-1)];
      
        %----- Find the first zero-crossing and the slope -DX
        [r,c]=size(x1);
        for k=1:r-1
           kk=r-k+1;
           if((x1(kk)*x1(kk-1))<=0)
           if(abs(x1(kk)) > abs(x1(kk-1)))
               n0=kk;
           else
               n0=kk-1;
           end
            
           if(((x1(kk)-x1(kk-1))*s0)>0)   %same sign as s0
               break;
           end
         end
      end
      x1=x1(1:n0);

    else
	zz=x1(n_mx:n_mn);
	mm=max(size(zz));
	zz1=flipud(zz);
	ia=fix((sz-n_mn)/(2*(mm-1)))+1;
	iaa=max(ia,2); %DX, modify constant from 1 to 2.
	iaa1=iaa*2;
	x1=x1(1:n_mn);
	for jj=1:iaa
	    x1=[x1;zz1(2:mm);zz(2:mm)];
	end
        x1=[x1;zz1(2:mm-1)];
        %----- Find the first zero-crossing and the slope -DX
        [r,c]=size(x1);
        for k=1:r-1
            kk=r-k+1;
            if((x1(kk)*x1(kk-1))<=0)
               if(abs(x1(kk)) > abs(x1(kk-1)))
                  n0=kk;
               else
                  n0=kk-1;
               end
            
               if(((x1(kk)-x1(kk-1))*s0)>0)   %same sign as s0
                  break;
               end
            end
        end
        x1=x1(1:n0);

    end
    %----- Apply Hilbert transform to the extended data
    x1=hilbert(x1);
    %----- Cut the extended portion
    x(:,j)=x1(np1:np1+n-1);
end

%----- Assign the output
h=x;
clear x

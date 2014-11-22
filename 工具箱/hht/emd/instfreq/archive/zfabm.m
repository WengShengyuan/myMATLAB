function [f, stdf, a, stda]=zfabm(data, dt)
%
%    [f,stdf,a,stda]=zfabm(data, dt):
%
%    Function to generate a zero-crossing (and extrema) frequency,
%    amplitude and their standard deviation of data(n,k),
%    where n specifies the length of time series, and k is number of IMFs.
%
%    Input-
%	data	- 2-D matrix data(n.k) of IMF components
%	dt	- time increment per point
%    Output-
%	f	- 2-D matrix f(n,k) that specifies mean frequency
%	stdf	- 2-D matrix stdf(n,k) that specifies frequency standard deviation
%	a	- 2-D matrix a(n,k) that specifies amplitude
%	stda	- 2-D matrix stda(n,k) that specifies amplitude standard deviation
%
%    Dan Xiang  (JHU)		April 10, 2002 Initial
%    Jelena Marshak (NASA GSFC)	November 19, 2003 Edited
%
%    Notes-
%    Non MATLAB Library routines used in the function are:
%	'zmn.m' (it is part of the 'zfabm()' )
%
%    Temporary remarks-
%    Changed the  function name, was 
%    'zfam()' for the code named as 'zfabm.m'.
%    Removed '_' from parameter names.

%----- Get dimensions
[npt,knb] = size(data);

%----- Initialize to zero
f=zeros(npt,knb);
stdf=zeros(npt,knb);
a=zeros(npt,knb);
stda=zeros(npt,knb);

%----- Process each IMF
for j=1:knb
  %----- Get extrema and zero crossing values
  [k,h,bf,ef]=zmn(data(:,j));
  KK=k;
  HH=h;
  L=length(k);
  %----- Process depending on number of extrema and zero crossings
  if L < 2
    %----- Process if number of extrema and zero crossings < 2
    for i=1:npt
        f(i,j)=0;
        a(i,j)=0;
        stdf(i,j)=100;
        stda(i,j)=100;
    end
  elseif L==2
    %----- Process if number of extrema and zero crossings = 2
    for i=1:npt
        f(i,j)=1/4/(k(2)-k(1));
        a(i,j)=abs(HH(2)-HH(1));
        stdf(i,j)=100;
        stda(i,j)=100;
    end
  else
    %----- Process if number of extrema and zero crossings > 2
    %----- Extend 3 points before the head
    d1=k(2)-k(1);
    d2=k(3)-k(2);
    if(d1<k(1))
      % disp(' Warning: extending head might be too far!')
    end
    n1=3+floor(k(1)/d1);
    for i=1:n1
        if mod(i,2)==1   
             KK=[KK(1)-d1; KK]; 
             HH=[HH(2)*(-1);HH];
        else
             KK=[KK(1)-d2;KK];
             HH=[HH(4); HH];
        end
    end
    %----- Extend 3 points after the end
    d1=k(L)-k(L-1);
    d2=k(L-1)-k(L-2);
    if(d1<(npt-k(L)))
      % disp(' Warning: extending tail might be too far!')
    end
    n2=3+floor((npt-k(L))/d1);
    for i=1:n2
        if mod(i,2)==1
            KK=[KK;KK(end)+d1]; 
            HH=[HH;HH(end-1)*(-1)];
        else
            KK=[KK;KK(end)+d2];
            HH=[HH;HH(end-3)];
        end
    end
    
    LL=length(KK);
    F1=ones(LL,1);
    F2=zeros(LL,1);
    F4=zeros(LL,1);
 %   H1=zeros(LL,1);
    H2=zeros(LL,1);
    H4=zeros(LL,1);
    
    %----- Process KK and HH
    t=diff(KK)*dt;
    t=[t;t(end)];
    F1=F1./t;
    h=diff(HH);
    h=[h;h(end)];
    H1=abs(h);
    
    for i=2:LL-1
        F2(i)=1/(KK(i+1)-KK(i-1))/dt;
        H2(i)=(H1(i+1)+H1(i-1))/2;
    end
    F2(LL)=F2(LL-1);
    F2(1)=F2(2);
    H2(LL)=(H1(LL-1)+H1(LL))/2;
    H2(1)=H2(2);
    
    %----- Average every two points
    for i=1:LL-2
        F2(i)=(F2(i)+F2(i+1))/2;
    end
    
    for i=3:LL-1
        F4(i)=3/4/(KK(i+1)-KK(i-2))/dt;  %DX, 5/3/02 fixed (3/4 period)
        H4(i)=(H1(i-2)+H1(i-1)+H1(i)+H1(i+1))/4;
    end
    F4(2)=F4(3);
    F4(1)=F4(2);
    F4(LL)=F4(LL-1);
    H4(2)=H4(3);
    H4(1)=H4(2);
    H4(LL)=H4(LL-1);
    
    %----- Average every four points
    for i=2:LL-2
        F4(i)=(F4(i-1)+F4(i)+F4(i+1)+F4(i+2))/4;
    end
    
    %----- Average all components
    ZZ=(F1+F2+F4)/7;
    HA=(4*H1+2*H2+H4)/7;
    
    II=n1+1;
    
    for i=1:npt
        if i>KK(II)
            II=II+1;
        end
        f(i,j)=ZZ(II);
        a(i,j)=HA(II);
        stdf(i,j)=sqrt((4*(F1(II)/4-ZZ(II))^2+2*(F2(II)/2-ZZ(II))^2+(F4(II)-ZZ(II))^2)/7);
 %       stdf=sqrt(stdf);
        stda(i,j)=sqrt((4*(H1(II)-HA(II))^2+2*(H2(II)-HA(II))^2+(H4(II)-HA(II))^2)/7);
 %       stda=sqrt(stda);
    end
    clear ZZ KK HH HA t F1 F2 F4 H1 H2 H4;
end
end

%----- Plot
te=[1:npt];
%----- Correct for plotting purposes (tmp)
stdf(:,8)=0;
stda(:,8)=0;
plot(te,f,te,stdf,te,a,te,stda, 'LineWidth', 1.5);
legend('Freq','Freq STD','AMP','AMP STD');

function [k,h,bf,ef]=zmn(x)
%    [k,h]=zmn(x):
%    Function extracts the set of zero-crossing,max,and min points of x(n),
%    where n specifies the dimension of array x.
%    The point x(i) is considered to be a local minimum if
%    x(i-1) > x(i) <= x(i+1);
%    The point x(i) is considered to be a local maximum if
%    x(i-1) < x(i) >= x(i+1);
%    The point x(i) is considered to be a zero-crossing if
%    x(i-1) and x(i) have different signs;
%
%    Input-
%	x	- input vector of values
%    Output-
%	k	- index vector that specifies the indexes of max, min
%		  and zero crossing values in the order found 
%	h	- vector that specifies corresponding max, min
%		  and zero values
%	bf	- flag of the begining point, where
%		  1 - max; 0 - zero crossing; -1 - min.
%	ef	- flag of the ending point, where
%		  1 - max; 0 - zero crossing; -1 - min.
%
%	Dan Xiang (JHU)		April 09, 2002 Initial
%
%    Temporary comments-
%    1) should be 'if bf==-100'
%
%----- Get dimensions
n=length(x);

%----- Use 5 points smoothing of x for n_mx and n_mn searching 
filtr=fir1(3,.1);
xx=filtfilt(filtr,1,x);
% xx=filtfilt(filtr,1,xx);
% xx=x;

%----- Initialize first point
n_x=1;
h=0;
k=0;
bf=-100;
ef=-100;

%----- Find extrema and zero crossing points of smoothed vector
for i=2:n-1
  flag=-100;
  if (xx(i-1)>xx(i))&(xx(i)<=xx(i+1)) % min
      h=[h xx(i)];
      k=[k i];
      n_x=n_x+1;
      flag=-1;
  elseif (xx(i-1)<xx(i))&(xx(i)>=xx(i+1)) %max
      h=[h xx(i)];
      k=[k i];
      n_x=n_x+1;
      flag=1;
  elseif (xx(i-1)*xx(i)<0)    %zero
      t=min(abs(xx(i-1)),abs(xx(i)));   
      if t==abs(xx(i-1))
        h=[h xx(i-1)];
        k=[k i-1];
      else
        h=[h xx(i)];
        k=[k i];
      end
      n_x=n_x+1;
      flag=0;
   end
   
   if flag~=-100  
      if bf==100
         bf=flag;
      else
         ef=flag;
      end
   end
end

%----- Add the last point there is zero-crossing
i=n;
if (xx(i-1)*xx(i)<0)
      t=min(abs(xx(i-1)),abs(xx(i)));
      if t==abs(xx(i-1))
        h=[h xx(i-1)];
        k=[k i-1];
      else
        h=[h xx(i)];
        k=[k i];
      end
      n_x=n_x+1;
      ef=0;
end

%----- Exclude the first point   
h=h(2:n_x);
h=h';
k=k(2:n_x);
k=k';

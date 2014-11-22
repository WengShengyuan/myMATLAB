function [w,a] = hfarm(data,dt,fa)
%
%   [f,a]=hfarm(data,dt,factor):   
%            Hilbert frequency and amplitude of data(n,k) with room window.
%	 data: input data.
%    dt:   sampling period in second.
%    factor: threshold factor ( greater than 2)
%   The outputs are:
%    f:    Hilbert frequency in Hz
%	 a:	 Hilbert amplitude
% 

%   DAN XIANG  4/5/02 initial
%              4/19/02 modified
%    when negative frequency appears, use threshold to room into local data 
%   
[npt,knb] = size(data);            %read the dimensions
h=zeros(npt,knb);

%----check negative frequency
for j=1:knb
     [w(:,j),a(:,j)]=fixfrq(data(:,j),dt, fa);   % call fix negative frequency function
end

%a=abs(h);
%w=diff(unwrap(angle(h)))/(2*pi*dt);
%w=(w+abs(w))/2;
%w=[w;w(npt-1)];


function [f,a] =fixfrq(x, dt, fa)
%
% function for fixing negative frequency points
% Input:
%    x - data vector
%    fa - factor that's used to lower the threshold 
% Output:
%    f - remedied Hilbert transform without negative frequency 
%    a - amplitude
      
%-----Hilbert Transform -----------
h= hilbt_m(x);
a=abs(h);
f=diff(unwrap(angle(h)))/(2*pi*dt);
f=[f;f(end)];
%---- search for negative frequency----
clear num index;
[num, index]=negf(f);
 num
 index
%--- lower the threshold with a given factor ---------------
th=max(abs(x))/fa; 
th
if num>0
    [mz,tz]=ezero(x);  % zero crossing
    if mz < 5  % stop if less than 2 waveforms
        disp('Warning: a negative frequency cannot be recovered, and will be forced to be zero!')
        f=(f+abs(f))/2;
    else
        [is,ie]=getIndex(x,th,index);
        for i=1:length(is)
            [mz,tz]=ezero(x(is(i):ie(i)));
            if mz >= 5
                ss=is(i)
                ee=ie(i)
                [tf,ta]=fixfrq(x(is(i):ie(i)),dt, fa);
                f(is(i)+1:ie(i)-1)=tf(2:end-1);
                f(is(i))=(f(is(i))+tf(1))/2;
                f(ie(i))=(f(ie(i))+tf(end))/2;
                a(is(i)+1:ie(i)-1)=ta(2:end-1);
                a(is(i))=(a(is(i))+ta(1))/2;
                a(ie(i))=(a(ie(i))+ta(end))/2;
            else
                disp('Warning: a negative frequency cannot be recovered, and will be forced to be zero!')
                f=(f+abs(f))/2;
            end
        end
    end
end
        
  
function [is,ie]=getIndex(x,th,index)
%
% function to find the start and ending index which satisfy following critiera
%   A. within a threshold amplitude that covers the given index data (negative frequency)
%   B. start and end at zero-crossing points with odd numbers
% Input:
%   x: data containing negative frequency
%   th:  threshold to find the start and end index
%   index: negative frequency index
% Output:
%   is:  index of start point (vector)
%   ie:  index of end point (vector)
%
is=[0];
ie=[0];
% for i=1:length(index)
i=1;
while i <=length(index)
    %---search for the start index---
    idx=index(i);
    doit=1;
    while doit ~= 0
        idx=idx-1;
        if idx == 0
            doit=0;
 %           is=[is, 1];
            st=1;
        else
            amp=abs(x(idx));
            if amp >= th
                doit =0;
 %               is=[is,idx];
                st=idx;
            end
        end
    end
    %---search for the ending index---
    idx=index(i);
    doit=1;
    while doit ~= 0
        idx=idx+1;
        if idx == (length(x)+1)
            doit=0;
            et=length(x);
        else
            amp=abs(x(idx));
            if amp >= th
                doit =0;
                et=idx;
            end
        end
    end    
    st
    et
    %---trim (st,et) to get zero crossing at both start and end---
    [mz,tz]=ezero(x(st:et));
    mz
    zt=tz(1)
    i
   nf= index(i)
    if mz < 5
        is=[is;st];
        ie=[ie;et];
    elseif mod(mz,2)==0
        if st+tz(1)-1 < index(i)
            is=[is;st+tz(1)-1];
            ie=[ie;st+tz(end-1)-1];
        else
  %          is=[is;st+tz(2)-1];
  %          ie=[ie;st+tz(end)-1];
            is=[is;st];
            ie=[ie;et];
        end
    else
        is=[is;st+tz(1)-1];
        ie=[ie;st+tz(end)-1];
    end
    
    %---check next index beyond (st,et) ------
    while i <=length(index)
        if ie(end) > index(i)
            i=i+1;
        else
            break;
        end
    end
end
is=is(2:length(is));
ie=ie(2:length(ie));


function [num, index]=negf(f)
%
% function for searching for negative frequency
% Input:
%    f - Hilbert frequency
% Output:
%    num - number of negative frequency points
%    index - index of negative frequecy points
num=0;
index=0;
for i=1:length(f)
    if f(i)<0
        num=num+1;
        index=[index; i];
    end
end

if num ~= 0
    index=index(2:num+1); %get ride of the initial 0
end

function [mz,tz]=ezero(x)
%
%  find zero crossing number and index
%
mz=0;
tz=0;
for i=2:length(x)
    if x(i)*x(i-1)<0
        mz=mz+1;
        if abs(x(i))<abs(x(i-1))
            tz=[tz; i];
        else
            tz=[tz;i-1];
        end
    end
end

if mz ~=0;
    tz = tz(2:mz+1);  %get ride of the initial 0
end
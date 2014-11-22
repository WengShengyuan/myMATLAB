function [h,xs,w] = nspabte(data,nyy,min_w,max_w,t0,t1)

% The function NSPABTE calculates the spectrum by applying the Teager Energy Operator
% to data(n,k), where n is the number of data points and 
% k is the number of IMF components.
% The Discrete Energy Separation Algorithm (DESA-1) 
% that applies Teager Energy Operator is used to extract
% the instantaneous frequency and amplitude from the data.
%
% Non MATLAB Library routine used is : DESA1M.
%
% Calling sequence-
% [h,xs,w]=nspabte(data,nyy,min_w,max_w,t0,t1)
%                                                
% Input-
%	data	    - 2-D matrix data(n,k) of IMF components
%	nyy	        - the frequency resolution
%	min_w	    - the minimum frequency
%	max_w	    - the maximum frequency
%	t0	        - the start time
%	t1	        - the end time
% Output-
%	h	        - 2-D matrix of the spectrum
%	xs	        - vector representing the time-axis
%	w	        - vector representing the frequency-axis
 
% Z. Shen (Caltech)	        July 2, 1995	Initial
% D. Xiang (JHU)	        March 27, 2002	Modified

[npt,knb] = size(data);            %read the dimensions
dt=(t1-t0)/(npt-1);

%-----Energy separation algorithm --------------------
[omg,a]=desa1m(data,dt);
   
clear data
for i=1:knb
   for i1=1:npt
      if omg(i1,i) >max_w,
         omg(i1,i)=max_w;
	 a(i1,i)=0;
      elseif omg(i1,i)<min_w,
         omg(i1,i)=min_w;
	 a(i1,i)=0;
      else
      end
   end
end

%----- get local frequency -----------------!
dw=max_w - min_w;
wmx=max_w;
wmn=min_w;
clear p;
%----- Construct the ploting matrix --------!
disp('Within the requested freq range max Amplitude =');
disp(max(max(a)));
h1=zeros(npt,nyy+1);
p=round(nyy*(omg-wmn)/dw)+1;
for j1=1:npt
   for i1=1:knb
      ii1=p(j1,i1);
      h1(j1,ii1)=h1(j1,ii1)+a(j1,i1);
   end
end

w=linspace(wmn,wmx,nyy+1)';
xs=linspace(t0,t1,npt)';
h=flipud(rot90(h1));
h=h(1:nyy,:);

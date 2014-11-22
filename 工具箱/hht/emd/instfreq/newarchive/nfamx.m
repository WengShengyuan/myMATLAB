function [nf, na, ex, E, N] = nfame(data,dt)
%
%   [nf,na,ex,E,N]=nfame(data,dt) :  Hilbert frequency and amplitude of data(n,k)
%    Based on renormalized data with spline fitting of maxima with the ends fixed.
%    The final frequency values are smoothed with a five point median filter.
%       The inputs are:
%               data = input data
%               dt =  sampling period in second.
%       The outputs are:
%               nf   :   Hilbert frequency in Hz
%               na  :   Hilbert Amplitude
%               ex  :   Splined envelop
%               E   :    Normalized data
%               N  :   Nonlinearity Index
%
%   Norden Huang  June 2, 2002

[n,m] = size(data); 
te=1:n; te=te';
%  [mx,tx]=emax(data);
[ex, emi]=envlp(data);  % Invoked New end treatment by Dan 06/12/02
%  which fixes the ends to prevent wide swaying in spline 
%  by assigning two extrema 

%  The following is just  assign one point at the ends on either side.
%  [p,q]=size(mx);
%  [u,v]=size(tx);
%  tx=[te(1);tx;te(n)];
%   mx=[mx(1);mx;mx(p)];
%   ex=spline(tx,mx,te);
E=data./ex;                         %  Normalizing the data by splined envelop

nf=diff(unwrap(angle(hilbt_m(E))))./(2*pi*dt);
nf=[nf;nf(n-1)];
na=abs(hilbt_m(E));

% add median for every 5 points, 5/4/02
for i=3:n-2
    nf(i,:)=median(nf(i-2:i+2,:));
    na(i,:)=median(na(i-2:i+2,:));
end
    
%  Compute the Nonlinear Index

N=(na-1).^2;

%  Re-constituting na
%  na=na.*ex;

%  Plot the results:

plot(te,data,te,ex,te,E,te,nf,te,na,te,N, 'LineWidth', 1.5);
legend('Data','ex','E','nf','na','N');
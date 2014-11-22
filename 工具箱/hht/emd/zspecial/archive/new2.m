% ----------------------------------------
% ----- Program to plot the signal example
% ----------------------------------------
 t=0:1023;t=t';
 w=2*pi/32;
 dw=.1*w;
 x=exp(i*w*t);
 x1=1+.7*exp(-i*dw*t)+.4*exp(i*dw*t);
 x1=x1-.8*i*exp(i*2*dw*t)+.3*i*exp(-i*dw*2*t);
 z=real(x1.*x);
 plot(t,z,t,real(x),':');

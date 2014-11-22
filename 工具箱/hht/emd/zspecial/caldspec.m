
% --- CALDSPEC calculates damping spectrums ----- % 
% from IMF for the specified files and plots them.
%
% Non MATLAB Library routines used are:
%	NSPABD and FDAMP.
% Required data files: 'cr921a'.
%
% --- caldspec.m -------------------------------- %

%----- Load the data 
load cr921a
h=cr921a';
m=size(h);

%----- Specify the scale
ts=(1:10000)./200;

%----- Get the damping spectrum
[nt,t,f]=nspabd(h(:,1:m(2)-7),100,0,5,ts(1),ts(length(ts)));

%---- Get the normalized marginal damping spectrum
msf=fdamp(nt);

%----- Plot spectrums
figure(1) 
imagesc(t,f,nt), axis xy

figure(2)
plot(f,msf)
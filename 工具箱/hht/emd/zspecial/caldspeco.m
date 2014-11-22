
% --- CALDSPECO calculates damping spectrums ------- %
% from IMF for the specified files and plot them.
%
% Non MATLAB Library routines used are:
%	NSPABD and FDAMP.
% Required data files: 'cr921c'.
%
% --- caldspeco.m ---------------------------------- %

%----- Load the data
load cr921c
h=cr921c';
m=size(h);

%----- Specify the scale
ts=(1:10000)./200;

%----- Get the damping spectrum
[nt,t,f]=nspabd(h(:,1:m(2)-5),100,0,5,ts(1),ts(length(ts)));

%---- Get the normalized marginal damping spectrum
msf=fdamp(nt);

%----- Plot spectrums
figure(1) 
imagesc(t,f,nt), axis xy

figure(2)
plot(f,msf)
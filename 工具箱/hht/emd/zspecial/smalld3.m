echo on;
% --- SMALLD3 loads data and plots their 3-D Hilbert spectrum.---- %
%
%     A program to load the series of files and
%     plot their 3-D Hilbert spectrum.
%
%     Non MATLAB Library routines used are:
%	NSPAB and FSPECIAL.
%
%     Data loaded is 'cp71301'-'cp713010'.
%     Short version of BIGD3HILBERT with no averaging
%	and different view angle.
%
%     See Lines Below to Change Cases
%              
%     N. E. Huang (NASA GSFC)	08.Feb. 2001 Initial
% --- smalld3.m --- Version 08.Feb.2001 -------------------------- %

clear;									% Start Fresh

load cp71301; cp71301=cp71301';					% Load HHT Results and Rotate
load cp71302; cp71302=cp71302';
load cp71303; cp71303=cp71303';
load cp71304; cp71304=cp71304';
load cp71305; cp71305=cp71305';
load cp71306; cp71306=cp71306';
load cp71307; cp71307=cp71307';
load cp71308; cp71308=cp71308';
load cp71309; cp71309=cp71309';
load cp713010; cp713010=cp713010'; 

[n1, x, k]=nspab(cp71301(:, 1:4),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n2, x, k]=nspab(cp71302(:, 1:5),128, 0,5,0, 26.54); 
[n3, x, k]=nspab(cp71303(:, 1:6),128, 0,5,0, 26.54); 
[n4, x, k]=nspab(cp71304(:, 1:5),128, 0,5,0, 26.54); 
[n5, x, k]=nspab(cp71305(:, 1:6),128, 0,5,0, 26.54); 
[n6, x, k]=nspab(cp71306(:, 1:5),128, 0,5,0, 26.54); 
[n7, x, k]=nspab(cp71307(:, 1:5),128, 0,5,0, 26.54); 
[n8, x, k]=nspab(cp71308(:, 1:6),128, 0,5,0, 26.54); 
[n9, x, k]=nspab(cp71309(:, 1:5),128, 0,5,0, 26.54); 
[n10, x, k]=nspab(cp713010(:, 1:5),128, 0,5,0, 26.54); 

q=fspecial('ga', 7, 0.7);		  							% Make Filter

n1=filter2(q, n1);n1=filter2(q, n1);n1=filter2(q, n1);	% Apply Filter
n2=filter2(q, n2);n2=filter2(q, n2);n2=filter2(q, n2);
n3=filter2(q, n3);n3=filter2(q, n3);n3=filter2(q, n3);
n4=filter2(q, n4);n4=filter2(q, n4);n4=filter2(q, n4);
n5=filter2(q, n5);n5=filter2(q, n5);n5=filter2(q, n5);
n6=filter2(q, n6);n6=filter2(q, n6);n6=filter2(q, n6);
n7=filter2(q, n7);n7=filter2(q, n7);n7=filter2(q, n7);
n8=filter2(q, n8);n8=filter2(q, n8);n8=filter2(q, n8);
n9=filter2(q, n9);n9=filter2(q, n9);n9=filter2(q, n9);
n10=filter2(q, n10);n10=filter2(q, n10);n10=filter2(q, n10);

N=zeros(128,170, 10);			% Make & Assemble Data Volume

N(:, :, 1)=n1;
N(:, :, 2)=n2;
N(:, :, 3)=n3;
N(:, :, 4)=n4;
N(:, :, 5)=n5;
N(:, :, 6)=n6;
N(:, :, 7)=n7;
N(:, :, 8)=n8;
N(:, :, 9)=n9;
N(:, :, 10)=n10;
save Nvar N x k;

tt=linspace(15, 25, 10)';

% --- Change this Value -----> x.xxx <---------- Change this Value -- %
p = patch(isosurface(x,k,tt,N, 0.01));
% ------------------------------------------------------------------- %
isonormals(x,k, tt, N, p)
set(p, 'FaceColor', 'cyan', 'EdgeColor', 'none');
daspect([.5 .1 0.25])
campos([-45 10 90]);
lighting phong;
grid off;
camlight left

% --- Change the Title ---> Case   Frames  Line No. Contour Level --- %
title( 'X Distance: 0-26 cm; Y Distance: 15-25 cm; Wavenumber: 0-4 1/cm')
toptitle('3D Hilbert Spectrum: NEH-07 F130 L193 to 492 C.01')
% ------------------------------------------------------------------- %

% --- smalld3.m Ends Normally --- %


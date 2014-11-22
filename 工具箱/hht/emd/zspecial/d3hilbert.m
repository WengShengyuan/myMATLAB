echo on;

% --- D3HILBERT loads files and plots their 3-D Hilbert spectrum. --- %
%
% Non MATLAB Library routines used are:
%	NSPAB, FSPECIAL and MSPC.
%
%     Required data files 'ci1'-'ci16'.
%
%     See Lines Below to Change Cases.
%
%     N. E. Huang (NASA GSFC)	23.Aug. 2000 Initial
% --- d3hilbert.m --- Version 23.Aug.2000 ---------------------------- %

clear;									% Start Fresh
clf;

load ci1; ci1=ci1';					% Load HHT Results and Rotate
load ci2; ci2=ci2';
load ci3; ci3=ci3';
load ci4; ci4=ci4';
load ci5; ci5=ci5';
load ci6; ci6=ci6';
load ci7; ci7=ci7';
load ci8; ci8=ci8';
load ci9; ci9=ci9';
load ci10; ci10=ci10'; 
load ci11; ci11=ci11';
load ci12; ci12=ci12';
load ci13; ci13=ci13';
load ci14; ci14=ci14';
load ci15; ci15=ci15'; 
load ci16; ci16=ci16';

[n1, x, k]=nspab(ci1(:, 1:4), 128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n2, x, k]=nspab(ci2(:, 1:4), 128, 0,5,0, 26.54); 
[n3, x, k]=nspab(ci3(:, 1:4), 128, 0,5,0, 26.54); 
[n4, x, k]=nspab(ci4(:, 1:4), 128, 0,5,0, 26.54); 
[n5, x, k]=nspab(ci5(:, 1:4), 128, 0,5,0, 26.54); 
[n6, x, k]=nspab(ci6(:, 1:4), 128, 0,5,0, 26.54); 
[n7, x, k]=nspab(ci7(:, 1:4), 128, 0,5,0, 26.54); 
[n8, x, k]=nspab(ci8(:, 1:4), 128, 0,5,0, 26.54); 
[n9, x, k]=nspab(ci9(:, 1:4), 128, 0,5,0, 26.54); 
[n10, x, k]=nspab(ci10(:, 1:4), 128, 0,5,0, 26.54); 
[n11, x, k]=nspab(ci11(:, 1:4), 128, 0,5,0, 26.54); 
[n12, x, k]=nspab(ci12(:, 1:4), 128, 0,5,0, 26.54); 
[n13, x, k]=nspab(ci13(:, 1:4), 128, 0,5,0, 26.54); 
[n14, x, k]=nspab(ci14(:, 1:4), 128, 0,5,0, 26.54); 
[n15, x, k]=nspab(ci15(:, 1:4), 128, 0,5,0, 26.54); 
[n16, x, k]=nspab(ci16(:, 1:4), 128, 0,5,0, 26.54); 

q=fspecial('ga', 11, 1.1);										% Make Filter

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
n11=filter2(q, n11);n11=filter2(q, n11);n11=filter2(q, n11);
n12=filter2(q, n12);n12=filter2(q, n12);n12=filter2(q, n12);
n13=filter2(q, n13);n13=filter2(q, n13);n13=filter2(q, n13);
n14=filter2(q, n14);n14=filter2(q, n14);n14=filter2(q, n14);
n15=filter2(q, n15);n15=filter2(q, n15);n15=filter2(q, n15);
n16=filter2(q, n16);n16=filter2(q, n16);n16=filter2(q, n16);

ms1 = mspc(n1,k);								% Normalized Marginal Spectra
ms2 = mspc(n2,k);
ms3 = mspc(n3,k);
ms4 = mspc(n4,k);
ms5 = mspc(n5,k);
ms6 = mspc(n6,k);
ms7 = mspc(n7,k);
ms8 = mspc(n8,k);
ms9 = mspc(n9,k);
ms10 = mspc(n10,k);
ms11 = mspc(n11,k);
ms12 = mspc(n12,k);
ms13 = mspc(n13,k);
ms14 = mspc(n14,k);
ms15 = mspc(n15,k);
ms16 = mspc(n16,k);

N=zeros(128,170, 16);			% Make & Assemble Data Volume
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
N(:, :, 11)=n11;
N(:, :, 12)=n12;
N(:, :, 13)=n13;
N(:, :, 14)=n14;
N(:, :, 15)=n15;
N(:, :, 16)=n16;

tt=linspace(0, 15/60, 16)';

% --- Change this Value -----> x.xxx <---------- Change this Value -- %
p = patch(isosurface(x,k,tt,N, 0.0005));
% ------------------------------------------------------------------- %
isonormals(x,k,tt,N, p)
set(p, 'FaceColor', 'cyan', 'EdgeColor', 'none');
daspect([.5 .1 0.01])
view(25,35);
lighting phong;
grid on;
camlight right
xlabel('Distance: cm')
ylabel('Wavenumber: 1/cm')
zlabel('Time: sec')

% --- Change the Title ---> Case   Frames  Line No. Contour Level --- %
title('3D Hilbert Spectrum: NEH-07 F120-135 L345 C.0005')
% ------------------------------------------------------------------- %

% --- MassHilbert.m Ends Normally --- %


echo on;
% --- masshilbert.m --- Version 22.Aug.2000 --- %
%
%     Test Code for 3D Hilbert Processing.
%     A program to load the series of files and
%     calculate their marginal spectrums.
%
%     N. E. Huang (NASA GSFC)	23.Aug. 2000 Initial
%
%     Notes-
%     Non MATLAB Library routines used are:
%	'nspab.m' and 'mspc.m'.
%     Data loaded is 'ci1'-'ci16'.
%     Filter q should be already loaded in memory, for example:
%	q=fspecial('ga', 11, 1.1);
% --- N. E. Huang at NASA GSFC ---------------- %

load ci1; ci1=ci1';
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

[n1, x, k]=nspab(ci1(:, 1:5), 128, 0,5,0, 26.54); 
[n2, x, k]=nspab(ci2(:, 1:5), 128, 0,5,0, 26.54); 
[n3, x, k]=nspab(ci3(:, 1:5), 128, 0,5,0, 26.54); 
[n4, x, k]=nspab(ci4(:, 1:5), 128, 0,5,0, 26.54); 
[n5, x, k]=nspab(ci5(:, 1:5), 128, 0,5,0, 26.54); 
[n6, x, k]=nspab(ci6(:, 1:5), 128, 0,5,0, 26.54); 
[n7, x, k]=nspab(ci7(:, 1:5), 128, 0,5,0, 26.54); 
[n8, x, k]=nspab(ci8(:, 1:5), 128, 0,5,0, 26.54); 
[n9, x, k]=nspab(ci9(:, 1:5), 128, 0,5,0, 26.54); 
[n10, x, k]=nspab(ci10(:, 1:5), 128, 0,5,0, 26.54); 
[n11, x, k]=nspab(ci11(:, 1:5), 128, 0,5,0, 26.54); 
[n12, x, k]=nspab(ci12(:, 1:5), 128, 0,5,0, 26.54); 
[n13, x, k]=nspab(ci13(:, 1:5), 128, 0,5,0, 26.54); 
[n14, x, k]=nspab(ci14(:, 1:5), 128, 0,5,0, 26.54); 
[n15, x, k]=nspab(ci15(:, 1:5), 128, 0,5,0, 26.54); 
[n16, x, k]=nspab(ci16(:, 1:5), 128, 0,5,0, 26.54); 

n1s=filter2(q, n1);
n2s=filter2(q, n2);
n3s=filter2(q, n3);
n4s=filter2(q, n4);
n5s=filter2(q, n5);
n6s=filter2(q, n6);
n7s=filter2(q, n7);
n8s=filter2(q, n8);
n9s=filter2(q, n9);
n10s=filter2(q, n10);
n11s=filter2(q, n11);
n12s=filter2(q, n12);
n13s=filter2(q, n13);
n14s=filter2(q, n14);
n15s=filter2(q, n15);
n16s=filter2(q, n16);

ms1 = mspc(n1s,k);
ms2 = mspc(n2s,k);
ms3 = mspc(n3s,k);
ms4 = mspc(n4s,k);
ms5 = mspc(n5s,k);
ms6 = mspc(n6s,k);
ms7 = mspc(n7s,k);
ms8 = mspc(n8s,k);
ms9 = mspc(n9s,k);
ms10 = mspc(n10s,k);
ms11 = mspc(n11s,k);
ms12 = mspc(n12s,k);
ms13 = mspc(n13s,k);
ms14 = mspc(n14s,k);
ms15 = mspc(n15s,k);
ms16 = mspc(n16s,k);

% --- masshilbert.m Ends Normally --- %


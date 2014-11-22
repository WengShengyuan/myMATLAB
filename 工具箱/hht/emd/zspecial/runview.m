echo off;
% --- RUNVIEW operates on Calibrated Slopes data   %
%                                                  %
%     Run the View Calibrated Slopes Program       %
%     VIEWCAL, and pass its info through           %
%     Global variables                             %
%                                                  %
% --- Steven R. Long at NASA GSFC / WFF ---------- %
% --- runview.m ------------ Version 22.Aug.00 --- %

% clear;                     		% Start With a Clear Memory

global filename start stop rownum1 rownum2 rownum3 B slice1 slice2 slice3

filename = 'OMP1099_07';		% File Name Series
start = 120;  				% First Image in Sequence
stop = 135;									% Last Image in Sequence
rownum1 = 128;				% Row Numbers to Display
rownum2 = 256;
rownum3 = 345;

% viewcal  % Views All 3 Lines
viewcal1	  % Views Bottom Line	% Program to Display Calibrated Images

% --- runview.m Ends Normally -------------------- %

echo on;

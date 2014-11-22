echo off;
% --- RUNPICK operates on Calibrated Slopes data   %
%                                                  %
%     Run the Pick Slices from Slopes Program      %
%     picker.m, and pass it info through           %
%     Global variables                             %
%                                                  %
% --- Steven R. Long at NASA GSFC / WFF ---------- %
% --- runpick.m ------------ Version 22.Aug.00 --- %

% clear;                     	% Start With a Clear Memory

global filename start stop rownum B slice

filename = 'OMP1099_07';	% File Name Series
start = 120;  			% First Image in Sequence
stop = 135;									% Last Image in Sequence
rownum = 345;			% Row Number to Pick Out

picker										% Program to Display Calibrated Images

% --- runpick.m Ends Normally -------------------- %

echo on;

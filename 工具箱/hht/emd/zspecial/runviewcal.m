echo off;

% --- RUNVIEWCAL operates on Calibrated Slopes data   %
%                                                     %
%     Run the View Calibrated Slopes Program          %
%     VIEWCALS, and pass its info through             %
%     Global variables.                               %
%                                                     %
% --- Steven R. Long at NASA GSFC / WFF ------------- %
% --- runviewcal.m --------- Version 29.Dec.99 ------ %

clear;                       			% Start With a Clear Memory

global filename start stop rownum B slice	% Set Up Global Variables

filename = 'OMP1099_10';				% File Name Series
start = 100;									% First Image in Sequence
stop = 120;									% Last Image in Sequence
rownum = 256;								% Row Number to Display

viewcals										% Program to Display Calibrated Images

% --- runviewcal.m Ends Normally ----------------- %

echo on;

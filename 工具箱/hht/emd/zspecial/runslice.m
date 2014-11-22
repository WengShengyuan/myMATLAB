echo off;
% --- RUNSLICE operates on Calibrated Slopes data   %
%                                                   %
%     Run the Slice Calibrated Slopes               %
%     SLICE, and pass it info through               %
%     Globals                                       %
%                                                   %
% --- Steven R. Long at NASA GSFC / WFF -------     %
% --- runslice.m ----------- Version 21.Aug.00 ---  %

global filename start rowstart numslices delslice B

filename = 'OMP1099_05';	% File Name Series (Change Path!)
start = 120;			% Image to Read from CD
rowstart = 11;				% First Row
numslices = 51;				% Total Slices
delslice = 10;				% Space Between Slices

slice											% Program to remove & Store Slices

% --- runslice.m Ends Normally ------------------- %

echo on;

echo off;
% --- RUNSAVE operates on Calibrated Slopes data   %
%                                                  %
%     Run the Save Slice Slopes Program            %
%     SAVESLICE, and pass its info through         %
%     Global variables.                            %
%                                                  %
% --- Steven R. Long at NASA GSFC / WFF ---------- %
% --- runsave.m ------------ Version 22.Aug.00 --- %

% clear;                     		% Start With a Clear Memory

global filename imgnum startrow B Bsub

filename = 'OMP1099_07';	% File Name Series
imgnum = 130;			% Image Number to Display
startrow = 193;			% Starting Row for Slice

saveslice	  		% Program to Display Calibrated Images

% --- runsave.m Ends Normally -------------------- %

echo on;

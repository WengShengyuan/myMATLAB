echo off;

% --- SLICE  operates on Calibrated Slopes data          %
%                                                        %
%  Get & Store Slope Image Slices from 10/99 Exp.        %
%                                                        %
%                                                        %
%  NOTE: Make sure CD Drive is Included in MATLAB Path   %
%                                                        %
% --- Steven R. Long at NASA Wallops Flight Facility --- %
% --- slice.m ------------- Version 21.Aug.00 ---------- %

global filename start rowstart numslices delslice B

% --- Work on Info Passed With Call -----	%

i = start;

if i <= 9; 
	datafile = [filename, '.00', num2str(i)];		% Assemble File Name
	fid = fopen(datafile, 'r');
else if i >= 10 & i <= 99;
		datafile = [filename, '.0', num2str(i)];
		fid = fopen(datafile, 'r');
	  end;
end;

if i >= 100 & i <= 500;
	datafile = [filename, '.', num2str(i)];
	fid = fopen(datafile, 'r');
end;
% ----------------------------------------------- %

	[A,count]=fread(fid,[512,512],'float32');	% Read In Image Data

	B=A.';												% Rotate to Match Camera View

for j = 1:numslices;
	rownum = rowstart + (j-1)*delslice;
	slice  = B(rownum,:);
   x = slice';
	redo = ['x', num2str(j), ' = x;'];
	eval(redo);
   Saveit = ['save e:\1job\x', num2str(j), ' x', ' -ascii'];
	eval(Saveit);
end;

	fclose('all');

% --- slice.m Ends Normally -------------------------- %

echo on;



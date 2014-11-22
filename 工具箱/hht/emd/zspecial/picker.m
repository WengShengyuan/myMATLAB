echo off;

% --- PICKER picks out raws from  Slope Image Files ------  %
%                                                           %
%  Pick Out Selected Row From Slope Image Files             %
%                                                           %
%       where: filename is CD file Prefix name, such        %
%                         as 'OMP1099_01'                   %
%              start is starting image ('001' to '500')     %
%              stop is stopping image ('001' to '500',      %
%                         and > or = start, a 'string'      %
%              rownum is horizontal row number for          %
%                         picking and storing               %
%                                                           %
%  NOTE: Make sure CD Drive is Included in MATLAB Pat       %
%                                                           %
%     Steven R. Long at NASA Wallops Flight Facility        %
% --- picker.m ------------ Version 22.Aug.00 ------------- %

global filename start stop rownum B slice

% --- Work on Info Passed With Call -----	%

numstart = start;
numstop  = stop;

loopr = 0;											% Count Loops

for i = numstart:numstop;		 				% Loop Through All Chosen Images

	loopr = loopr +1;

Go = input('Input 1 to Continue:  ');

% --- Open the Files in Order ------------------- %
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
	x=linspace(0,26.54,512);
	y=linspace(0,26.54,512);
   rowloc = (rownum/512)*26.54;

	figure(1);
	imagesc(x,y,B);
	colormap('winter');
	colorbar;
   T = ['Case: OMP-',filename(9:10), '   Frame: ', num2str(numstart + (loopr-1))];
	title(T);
	xlabel('Downwind Distance (cm)');
	ylabel('Crosswind Distance (cm)');
   axis square
	hold on;
	plot(x,rowloc,'-w');

	hold off

   figure(2);
	slice = B(rownum,:);
	plot(x,slice);
   axnum = axis;
	axis([axnum(1) 26.54 axnum(3) axnum(4)]);
	T2 = [T, '  Row Location: ', num2str(rowloc), '  cm'];
	title(T2)
	ylabel('Calibrated Slope');
	xlabel('Downwind Distance (cm)');

	slice = slice';
	fixshape = ['x', num2str(loopr), ' = slice;'];
	eval(fixshape);
	storeit = ['save e:\1job\x', num2str(loopr), ' x', num2str(loopr) ...
	, ' -ascii'];
	eval(storeit);

	fclose('all');
end;

% --- picker.m Ends Normally -------------------------- %

echo on;



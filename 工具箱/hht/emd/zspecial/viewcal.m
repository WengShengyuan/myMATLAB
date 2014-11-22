echo off;

% --- VIEWCAL operates on Calibrated Slopes data         %
%                                                        %
%  View Calibrated Slope Image Files from 10/99 Exp.     %
%                                                        %
%       where: filename is CD file Prefix name, such     %
%                         as 'OMP1099_01'                %
%              start is starting image ('001' to '500')  %
%              stop is stopping image ('001' to '500',   %
%                         and > or = start, a 'string'   %
%                rownum is horizontal row number for     %
%                         slice to monitor               %
%                                                        %
%  NOTE: Make sure CD Drive is Included in MATLAB Path   %
%                                                        %
% --- Steven R. Long at NASA Wallops Flight Facility --- %
% --- viewcal.m ----------- Version 22.Aug.00 ---------- %

global filename start stop rownum1 rownum2 rownum3 B slice1 slice2 slice3

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
   rowloc1 = (rownum1/512)*26.54;
   rowloc2 = (rownum2/512)*26.54;
   rowloc3 = (rownum3/512)*26.54;

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
	plot(x,rowloc1,'-w');
	plot(x,rowloc2,'-w'); 
	plot(x,rowloc3,'-w'); 

	hold off

   figure(2);
	subplot(3,1,1)
	slice1 = B(rownum1,:);
	plot(x,slice1);
   axnum = axis;
	axis([axnum(1) 26.54 axnum(3) axnum(4)]);
   rowloc1 = (rownum1/512)*26.54;
	T2 = [T, '  Row Location: ', num2str(rowloc1), '  cm'];
	title(T2)
	ylabel('Calibrated Slope');

	subplot(3,1,2)
	slice2 = B(rownum2,:);
	plot(x,slice2);
   axnum = axis;
	axis([axnum(1) 26.54 axnum(3) axnum(4)]);
   rowloc2 = (rownum2/512)*26.54;
	T3 = [T, '  Row Location: ', num2str(rowloc2), '  cm'];
	title(T3)
	ylabel('Calibrated Slope');
	
	subplot(3,1,3)
	slice3 = B(rownum3,:);
	plot(x,slice3);
   axnum = axis;
	axis([axnum(1) 26.54 axnum(3) axnum(4)]);
   rowloc2 = (rownum2/512)*26.54;
	T3 = [T, '  Row Location: ', num2str(rowloc3), '  cm'];
	title(T3)
	ylabel('Calibrated Slope');
	xlabel('Downwind Distance (cm)');
	max(slice1)
	max(slice2)
	max(slice3)

	fclose('all');
end;

% --- viewcal.m Ends Normally -------------------------- %

echo on;



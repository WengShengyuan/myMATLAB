echo off;

% --- VIEWCALS operates on Calibrated Slopes data        %
%                                                        %
%  View Calibrated Slope Image Files from 10/99 Exp.     %
%                                                        %
%  nt = viewcals(filename,start,stop,rownum);            %
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
% --- viewcals.m ---------- Version 23.Dec.99 ---------- %

global filename start stop rownum B slice	% Receives Data Passed In

% --- Work on Info Passed With Call -----	%

numstart = start;
numstop  = stop;

for i = numstart:numstop;						% Loop Through All Chosen Images

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
	figure(1);
	imagesc(B);
	colormap('Gray');
	title('Full Cailbrated Slope Image: 512 x 512');
	figure(2);
	slice = B(rownum,:);
	plot(slice);
	title('Downwind Slice at Selected Row')
	ylabel('Calibrated Slope');
	xlabel('Downwind Pixels');
	fclose('all');
end;

% --- viewcals.m Ends Normally ------------------------- %

echo on;



echo off;

% --- SAVESLICE  operates on Calibrated Slopes data       %
%                                                         %
%  View Calibrated Slope Image Files from 10/99 Exp.      %
%  View Bottom Line Only, where                           %
%	filename is CD file Prefix name, such      	  %
%		as 'OMP1099_01'                           %
%       imgnu is image number to display                  %
%	startrow is starting row for slice       	  %
%  NOTE:Make sure CD Drive is Included in MATLAB Path     %                                          %	Called by RUNSAVE                                 %
%                                                         %
% --- Steven R. Long at NASA Wallops Flight Facility ---- %
% --- saveslice.m ----------- Version 08.Feb.01 --------- %

global filename imgnum startrow B Bsub

% --- Work on Info Passed With Call -----------	%

% --- Open the Selected File ------------------ %

	if imgnum <= 9; 
		datafile = [filename, '.00', num2str(imgnum)];	% Assemble File Name
		fid = fopen(datafile, 'r');
	else if imgnum >= 10 & i <= 99;
			datafile = [filename, '.0', num2str(imgnum)];
			fid = fopen(datafile, 'r');
   end;
	end;
	if imgnum >= 100 & imgnum <= 500;
		datafile = [filename, '.', num2str(imgnum)];
		fid = fopen(datafile, 'r');
	end;
% ----------------------------------------------- %

	[A,count]=fread(fid,[512,512],'float32');	% Read In Image Data

	B=A.';												% Rotate to Match Camera View
	x=linspace(0,26.54,512);
	y=linspace(0,26.54,512);
   startloc = (startrow/512)*26.54;
   stoploc  = (startrow + 299)/512*26.54;
	ysub=linspace(10.,25.5,100);

	figure(1);
	imagesc(x,y,B);
	colormap('winter');
	colorbar;
   T = ['Case: OMP-',filename(9:10), '   Frame: ', num2str(imgnum)];
	title(T);
	xlabel('Downwind Distance (cm)');
	ylabel('Crosswind Distance (cm)');
   axis square
	hold on;
	plot(x,startloc,'-w');
	plot(x,stoploc,'-w'); 				% Plot a Line to Mark
hold off

   figure(2);

	Bsub = B(startrow:(startrow+299),:);
	imagesc(x,ysub,Bsub);
	colormap('winter');
	colorbar;
	T3 = [T, '  Subsection From: ', num2str(startrow), ' row'];
	title(T3)
	ylabel('Calibrated Slope');
	xlabel('Downwind Distance (cm)');

	fclose('all');

% --- Now Output Slices for Processing --- %

outname = ['P7', num2str(imgnum)];

numrows = min(size(Bsub));
j=0;
for i = 1:3:numrows;
    j=j+1;
        Bout = Bsub(i,:)';
    outfile = [outname, num2str(j),'.dat'];
    saveit = ['save ',outfile, '  Bout -ascii'];
    eval(saveit);
end;
echo on;

% --- saveslice.m Ends Normally -------------------------- %





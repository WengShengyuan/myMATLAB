% --- test3d.m ------- Version 08.Feb.2001 ------ %
%                                                  
%     Test Loops for 3D Hilbert Processing.
%     An example program for loading a series of files and
%     calculating the 2-D Hilbert spectrum for each of them-
%     similar to smalld3.m'.         
%                                                  
% --- N.E. Huang & S. R. Long at NASA GSFC ------ %

clear;									% Start Fresh
load cp71301; cp71301=cp71301';					% Load HHT Results and Rotate
load cp71302; cp71302=cp71302';
load cp71303; cp71303=cp71303';
load cp71304; cp71304=cp71304';
load cp71305; cp71305=cp71305';
load cp71306; cp71306=cp71306';
load cp71307; cp71307=cp71307';
load cp71308; cp71308=cp71308';
load cp71309; cp71309=cp71309';
load cp713010; cp713010=cp713010'; 

[n1, x, k]=nspab(cp71301(:, 1:4), 128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n2, x, k]=nspab(cp71302(:, 1:4), 128, 0,5,0, 26.54); 
[n3, x, k]=nspab(cp71303(:, 1:4), 128, 0,5,0, 26.54); 
[n4, x, k]=nspab(cp71304(:, 1:4), 128, 0,5,0, 26.54); 
[n5, x, k]=nspab(cp71305(:, 1:4), 128, 0,5,0, 26.54); 
[n6, x, k]=nspab(cp71306(:, 1:4), 128, 0,5,0, 26.54); 
[n7, x, k]=nspab(cp71307(:, 1:4), 128, 0,5,0, 26.54); 
[n8, x, k]=nspab(cp71308(:, 1:4), 128, 0,5,0, 26.54); 
[n9, x, k]=nspab(cp71309(:, 1:4), 128, 0,5,0, 26.54); 
[n10, x, k]=nspab(cp713010(:, 1:4), 128, 0,5,0, 26.54); 

% echo off;
%for i=2:10;
%	doload = ['load cp7130',num2str(i),';'];
%	eval(doload);
%	dotrans = ['cp7130',num2str(i),'=cp7130',num2str(i),';'];
%	eval(dotrans);
%	dospec = ['[n', num2str(i),', x, k]=nspab(cp7130',num2str(i), ...
%          '(:, 1:2), 128, 0,5,0, 26.54);'];
%eval(dospec);
%end;

%echo on;

% --- test3d Ends Normally --- %


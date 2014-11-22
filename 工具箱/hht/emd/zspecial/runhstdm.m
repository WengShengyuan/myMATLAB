echo on;

% --- RUNHSTDM finds the std array ------------------- %
%                                                      %
%    Run Huang std: Find the std array that gives      %
%               the std pt. by pt. for N arrays        %
%    Calls: HSTDM                                      %
%                                                      %
%     This is the Memory Version that Needs All        %
%     Arrays in Memory                                 %
%                                                      %
% --- The global passes values to hstdm.m ------------ %
%     file_series: name of file without trailing       %
%                    number or .dat extension          %
%     file_ending: .dat, etc.                          %
%     N: Total number of identical arrays              %
%     av: Array to accumulate the average              %
%     astd: Array for the std answers                  %
%                                                      %
% --- NOTES: ----------------------------------------- %
%                                                      %
% This Version is for ASCII Array Files Only           %
% Put Array Location in MATLAB Set Path,               %
%		not in file_series                     %
% Results av and astd arrays                           %
% will also be in memory at close of program           %
%                                                      %
% --- Steven R. Long at NASA GSFC / WFF -------------- %
% --------- runhstdm.m --- Version 13.April.2000 ----- %

global file_series file_ending N av astd Nstd

% --- Enter Values to Control hstdm.m runs ------------ %

file_series = 'n';						% Part of All Array Names
N = 4;												% Number in Series

hstdm;												% Gets std of array series in memory
														% And stores as hstdfile_series.mat

% --- Program runhstdm.m Ends Normally --- %

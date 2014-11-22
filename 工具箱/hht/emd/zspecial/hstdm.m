echo on;

% --- HSTDM finds std array        --------------- %
%                                                  %
%    Huang std: Find the std array that gives      %
%               the std pt. by pt. for N arrays    %
%    Called by: RUNHSTDM                         %
%                                                  %
%    This is Memory Version that Needs             %
%    Arrays Loaded into Memory Already             %
%                                                  %
%                                                  %
%    The global passes values in from runhstdm.m   %
%    file_series: name of file without trailing    %
%                    number or .dat extension      %
%    file_ending: .dat, etc.                       %
%    N: Total number of identical arrays           %
%    av: Array to accumulate the average           %
%    astd: Array for the std answers               %
%                                                  %
%    Steven R. Long at NASA GSFC / WFF             %
% --------- hstdm.m ---- Version 06.June.2001 ---- %

global file_series file_ending N av astd Nstd

% --- Get First Array ---------------------------- %

renameit = ['first_array = ', file_series, '1;'];
eval(renameit);									% Rename first array

[rows,cols] = size(first_array);				% Get Size of First Array

astd = zeros(rows,cols);						% Set Up Storage
Nstd = astd;
av = first_array;									% Put First Array in Average
clear first_array;								% Clear Memory

% -- Now Get the Other Arrays, One by One --- %

echo off;											% Prevent Screen Flooding

if N > 1;											% Do Average if > 1 Array

for i=2:N;

	getnext = ['next_array = ', file_series, num2str(i), ';'];
	eval(getnext);									% Rename next array

	av = av + next_array;						% Accumulate into Average

end;

end;													% Jump to Here if Only 1 Array

echo on;

av = av / N;										% Average Array Complete

% --- Now Call Back All Arrays to Find Variance & std --- %

echo off;											% Prevent Screen Flooding

for i=1:N;

	getnext = ['next_array = ', file_series, num2str(i), ';'];
	eval(getnext);									% Rename next array

	difr = av - next_array;						% Find Square of Difference
	difr = difr .* difr;

	astd = astd + difr;							% Accumulate	

end;

echo on;

astd = astd / N;									% Variance

sigma = sqrt(abs(astd));

echo off;											% Prevent Screen Flooding

for i = 1:rows;									% Get std
	for j = 1:cols;
		astd(i,j) = sqrt(astd(i,j));
	end;
end;

for i = 1:rows;									% Get Nstd
	for j = 1:cols;
		if av(i,j) == 0.;
			Nstd(i,j) = 0.;
		else Nstd(i,j) = astd(i,j) / av(i,j);
		end;
	end;
end;

% Nstd = astd ./ av;   % Get Nstd Old Way


echo on;

% --- Save Result as a MATLAB .mat file ----- %

saveit = ['save ', 'hstd', file_series, ' av Nstd astd sigma;'];
eval(saveit);

% --- Program hstdm.m Ends Normally --- %

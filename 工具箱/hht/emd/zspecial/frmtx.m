function wa=frmtx(str,n,n_x)

% The function FRMTX makes n vectors of data to form a matrix.
% Data is saved in files.
% 
% FRMTX loads n 1-D files, each containing one vector
% which is dimensioned as n_x and which names start with 'str'.
%
% Example: R1,...,R8 are 8 vectors of 1024 points in c:\1boil,
% then z=frmtx('R',8,1024) will return the matrix z(1024,8) wanted.
% Here r1 is different R1, take care the case of names. 
% The name-numbering must begin from 1, i.e., R1.
% This creates the input for ro2xy.cpp.
%
% Calling sequence-
% z=frmtx(str,n,n_x)
%
% Input-
%	str	- characters, that represent a common part of vector names
%	n	- number, that represents a numeric part of a vector name
%	n_x	- number, that represents a number of vectors
% Output-
%	wa	- matrix wa(n_x,n) of n input vectors in column form	
 
% Z. Shen (Caltech)		March 1997 Initial

wa=zeros(n_x,n);
for i=1:n;
   s2=[str num2str(i)];
   eval(['load ' s2]);
   eval(['x=' s2 ';']);
   wa(:,i)=x;
   eval(['clear ' s2]);
end

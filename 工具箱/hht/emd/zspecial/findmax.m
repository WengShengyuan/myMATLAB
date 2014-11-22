
% --- FINDMAX plots IMF components in strips format  -------- %
% in order to pick the principal Components.
%
% To run, change the file name of IMF.
%
% Required data files 'x00g' and 'c00g'. 
%
% Program created for BIGSKY, March 18, 2000 by Norden E. Huang
% --- findmax.m --- Version 23.Aug.2000 --------------------- %

load x00g;
load c00g; c00g=c00g';
tt=linspace(0,10,1000)';
strips(c00g);

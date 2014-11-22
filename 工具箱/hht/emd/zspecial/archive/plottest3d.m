% --- plottest3d.m ------------------------------- %
%
% Test Code for 3D Hilbert Processing.
% A program to plot 3-D Hilbert spectrum
% saved previously in the file 'Nvar.mat'.
%
% ------------------------------------------------ %

load Nvar;
figure(2)

tt=linspace(15, 25, 100)';

% --- Change this Value -----> x.xxx <---------- Change this Value -- %
p = patch(isosurface(x,k,tt,N, 0.001));
% ------------------------------------------------------------------- %
isonormals(x,k, tt, N, p)
set(p, 'FaceColor', 'cyan', 'EdgeColor', 'none');
daspect([.5 .2 0.25])
campos([45 20 110]);
lighting phong;
grid on;
camlight left

% --- Change the Title ---> Case   Frames  Line No. Contour Level --- %
title( 'X Distance: 0-26 cm; Y Distance: 15-25 cm; Wavenumber: 0-4 1/cm')
toptitle('3D Hilbert Spectrum: NEH-07 F130 L193 to 492 C.001')

% --- plottest3d.m Ends Normally --- %


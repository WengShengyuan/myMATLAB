
% --- PLOT3D plots the 3-dimensional perspective --- %
% of either Hilbert or Wavelet results.                                         %
% Requires the following data file: wvlt,
% which contains the 3-d volume, and axes.
%
% See marked lines in the code to change cases.
%
% S. R. Long (NASA GSFC)	09.Feb. 2001 Initial
% N. E. Huang (NASA GSFC)	14.Feb. 2001 Modified
%  -----  plot3d.m ----------------------------------%  

load wvlt;
figure(2)

tt=linspace(15, 25, 100)';

% --- Change this Value -----> x.xxx <---------- Change this Value -- %

p = patch(isosurface(wx,k,tt,W, 0.6));

isonormals(wx,k, tt, W, p)

% ------------------------------------------------------------------- %

set(p, 'FaceColor', 'cyan', 'EdgeColor', 'none');
daspect([.5 .2 0.25])
campos([-45 20 110]);
lighting phong;
grid on;
camlight left

% --- Change the Title ---> Case   Frames  Line No. Contour Level --- %

title( 'X Distance: 0-26 cm; Y Distance: 15-25 cm; Wavenumber: 0-4 1/cm')

toptitle('3D Wavelet Spectrum: NEH-07 F130 L193 to 492 C.6')

% --- Plot3d.m Ends Normally --- %


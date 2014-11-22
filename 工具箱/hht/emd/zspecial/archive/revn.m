% --- revn.m ------------------------------------- %
%
% Test Code for 3D Hilbert Processing.
% A program to plot 3-D Hilbert spectrum
% saved previously in the file 'Nvar.mat' and reversed
% before plotting.
%
% Note: if the amplitude of saved spectrum is positive,
% than no values will be plotted unless zvalue in the
% 'isosurface(x,k,tt,N, zvalue)' function is negative.
% ------------------------------------------------ %

load Nvar;
N=-1*N;

tt=linspace(15, 25, 100)';

% --- Change this Value -----> x.xxx <---------- Change this Value -- %
p = patch(isosurface(x,k,tt,N, 0.01));
% ------------------------------------------------------------------- %
isonormals(x,k, tt, N, p)
set(p, 'FaceColor', 'cyan', 'EdgeColor', 'none');
daspect([.5 .1 0.25])
view(125,60);
lighting phong;
grid on;
camlight right
xlabel('Distance: cm')
zlabel('Wavenumber: 1/cm')
ylabel('Distance: cm')

% --- Change the Title ---> Case   Frames  Line No. Contour Level --- %
title('3D Hilbert Spectrum: NEH-07 F130 L193 to 492 C.01')
% ------------------------------------------------------------------- %



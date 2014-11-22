% --- d3view.m ----------------------------------- %
%
%     Test Code for 3D Hilbert Processing.
%     A program to plot 3-D data.
%
% ------------------------------------------------ %
 figure(3);
 p=patch(isosurface(x, k, z, N, 0.1));
 set(p, 'FaceColor', 'blue', 'EdgeColor', 'none');
 daspect([4, 0.5, 1]);
 view(160, -35)
 camlight(160, 120);
 grid
 axis([0 30 0 8 0 6]);

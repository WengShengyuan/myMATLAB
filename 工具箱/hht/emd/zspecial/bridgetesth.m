
% --- BRIDGETESTH computes the Hilbert Spectrum based on principal --- %
% components of the sifted bridge vibration data.
%
% High Frequeny 2 to 25 Hz; c1&c1 Components only
%
% To run the program, make sure to change the names of the
%  Data and the Sifted IMF files.
%  
% Default frequency range 2 to 25 Hz;
% Default time range 0 to 6 second;
% Default Hilbert Spectrum : HSV Color
% Non MATLAB Library routines used are: NSPAB.
%
% Required data files:
%	'x11g', 'c11g'.
%
% Program created for BIGSKY  : March 18, 2000 by Norden E. Huang
% --- bridgetesth.m --------------------------------------------- %


load x11g;
load c11g; c11g=c11g';
tt=linspace(0,10,1000)';
strips(c11g);
title('IMF Components : c11g');
print -djpeg90 imfc11g;
[n, t, f]=nspab(c11g(:, 1:3), 200, 2, 25, 0, 10);
figure(2);
contour(t, f, n.^.5);
axis([0 6 2 25]);
title('Hilbert Spectrum & Data : c11g');
xlabel('Time : second');
ylabel('Frequency : Hz');
hold on
plot(tt, x11g*30+7, 'LineWidth', 1.5);
print -djpeg90 cont11gh;
figure(3)
img(t, f, n.^.5);
axis([0 6 2 25]);
title('Hilbert Spectrum & Data : c11g');
xlabel('Time : second');
ylabel('Frequency : Hz');
colorbar
colormap(hsv);
hold on
plot(tt, x11g*30+7, 'LineWidth', 1.5);
print -djpeg90 hilb11gh;


% --- BRIDGETESTL computes the Hilbert Spectrum based on principal --- %
% components of the sifted bridge vibration data.
% Lower Frequency 0 to 3 Hz range.
%
% To run the program, make sure to change the names of the
%  Data and the Sifted IMF files.
%  
% Default frequency range 0 to 3 Hz;
% Default time range 0 to 6 second;
% Default Hilbert Spectrum : HSV Color
% Non MATLAB Library routines used are:
%	NSPAB.
% Required data files:
%	'x12g', 'c12g'.
%
% Program created for BIGSKY  : March 18, 2000 by Norden E. Huang
% --- bridgtestl.m -------------------------------------------------- %


load x12g;
load c12g; c12g=c12g';
tt=linspace(0,10,1000)';
strips(c12g);
title('IMF Components : c12g');
print -djpeg90 imfc12g;
[n, t, f]=nspab(c12g(:, 7), 200, 0, 3, 0, 10);
figure(2);
contour(t, f, n.^.5);
axis([0 6 0 3]);
title('Hilbert Spectrum & Data : c12g');
xlabel('Time : second');
ylabel('Frequency : Hz');
hold on
plot(tt, x12g*10+2, 'LineWidth', 1.5);
print -djpeg90 cont12gl;
figure(3)
img(t, f, n.^.5);
axis([0 6 0 3]);
title('Hilbert Spectrum & Data : c12g');
xlabel('Time : second');
ylabel('Frequency : Hz');
colorbar
colormap(hsv);
hold on
plot(tt, x12g*10+2, 'LineWidth', 1.5);
print -djpeg90 hilb12gl;

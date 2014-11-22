
% --- BRIDGETEST computes the Hilbert Spectrum based on principal --- %
% components of the sifted bridge vibration data.
%
% To run the program, make sure to change the names of the
%  Data and the Sifted IMF files.
%  
% Default frequency range 2 to 8 Hz;
% Default time range 0 to 6 second;
% Default Hilbert Spectrum : HSV Color
% Non MATLAB Library routine used is: NSPAB
%
% Required data files:
%	'x41g', 'c41g'.
%
% Program created for BIGSKY  : March 18, 2000 by Norden E. Huang
% --- bridgtest.m ---------------------------------------------- %



load x41g;
load c41g; c41g=c41g';
tt=linspace(0,10,1000)';
strips(c41g);
title('IMF Components : c41g');
print -djpeg90 imfc41g;
[n, t, f]=nspab(c41g(:, 5), 200, 2, 8, 0, 10);
figure(2);
contour(t, f, n.^.5);
axis([0 6 2 8]);
title('Hilbert Spectrum & Data : c41g');
xlabel('Time : second');
ylabel('Frequency : Hz');
hold on
plot(tt, x41g*30+7, 'LineWidth', 1.5);
print -djpeg90 cont41g;
figure(3)
img(t, f, n.^.5);
axis([0 6 2 8]);
title('Hilbert Spectrum & Data : c41g');
xlabel('Time : second');
ylabel('Frequency : Hz');
colorbar
colormap(hsv);
hold on
plot(tt, x41g*30+7, 'LineWidth', 1.5);
print -djpeg90 hilb41g;

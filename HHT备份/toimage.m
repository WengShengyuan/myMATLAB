

function [im,tt] = toimage(A,f,t,splx,sply)
% [im,tt] = TOIMAGE(A,f,t,splx,sply) transforms a spectrum made
% of 1D functions (e.g., output of "spectreh") in an 2D
% image（求完瞬时频率和瞬时幅值后要用toimage函数把一维频谱转换成二维图输出）
%
% inputs :   - A    : amplitudes of modes (1 mode per row of A)（幅度模值，每一行为一级imf的幅度模值）
%            - f    : instantaneous frequencies（瞬时频率）
%            - t    : time instants （截断时间）
%            - splx : number of columns of the output im (time resolution).
%                     If different from length(t), works only for uniform 
%                     sampling.（输出图像的列数，如果不同于t的长度，则只适合于均匀采样）
%            - sply : number of rows of the output im (frequency
%            resolution).（输出图像的行数）
% outputs :  - im   : 2D image of the spectrum（2维频谱图）
%            - tt   : time instants in the image（在图中的截断时间）
%
% utilisation : [im,tt] = toimage(A,f);[im,tt] = toimage(A,f,t);[im,tt] = toimage(A,f,sply);
%              [im,tt] = toimage(A,f,splx,sply);[im,tt] = toimage(A,f,t,splx,sply);
DEFSPL = 400;
% DEFSPL = 500;
% DEFSPL = 300;
if nargin < 3
  t = 1:size(A,2);
  sply = DEFSPL;
  splx = length(t);
else
    if length(t) == 1
        tp = t;
        t = 1:size(A,2);
        if nargin < 4
            sply = tp;
            splx = length(t);
        else
            if nargin > 4
                error('too many arguments')
            end
            sply = splx;
            splx = tp;
        end
    else
        lt = length(t);
       
        if nargin < 4
          sply = DEFSPL;
          splx = lt;
        end
        
        if nargin < 5
          sply = splx;
          splx = lt;
        end
        if nargin > 5
            error('too many arguments')
        end
    end
end
    
%end
lt=length(t);
im=[];
im(splx,sply) = 0;
for i=1:size(f,1)
  for j = 1:lt
    ff=floor(f(i,j)*2*(sply-1))+1;
    if ff <= sply % in case f(i,j) > 0.5
      im(floor(j*(splx-1)/lt)+1,ff)=im(floor(j*(splx-1)/lt)+1,ff)+A(i,j);
    end
  end  
end
for i = 1:splx
  tt(i) = mean(t(floor((i-1)*lt/(splx))+1:floor(i*lt/(splx))));
end
im=fliplr(im)';
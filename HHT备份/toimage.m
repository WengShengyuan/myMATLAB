

function [im,tt] = toimage(A,f,t,splx,sply)
% [im,tt] = TOIMAGE(A,f,t,splx,sply) transforms a spectrum made
% of 1D functions (e.g., output of "spectreh") in an 2D
% image������˲ʱƵ�ʺ�˲ʱ��ֵ��Ҫ��toimage������һάƵ��ת���ɶ�άͼ�����
%
% inputs :   - A    : amplitudes of modes (1 mode per row of A)������ģֵ��ÿһ��Ϊһ��imf�ķ���ģֵ��
%            - f    : instantaneous frequencies��˲ʱƵ�ʣ�
%            - t    : time instants ���ض�ʱ�䣩
%            - splx : number of columns of the output im (time resolution).
%                     If different from length(t), works only for uniform 
%                     sampling.�����ͼ��������������ͬ��t�ĳ��ȣ���ֻ�ʺ��ھ��Ȳ�����
%            - sply : number of rows of the output im (frequency
%            resolution).�����ͼ���������
% outputs :  - im   : 2D image of the spectrum��2άƵ��ͼ��
%            - tt   : time instants in the image����ͼ�еĽض�ʱ�䣩
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
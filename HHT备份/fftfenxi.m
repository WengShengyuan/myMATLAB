function [f,z] = fftfenxi(t,y)
%%%clear;clc;
%%%
N=length(t)
%fftĬ�ϼ�����ź��Ǵ�0��ʼ��
%%%t=linspace(1,2,N);deta=t(2)-t(1);1/deta
deta = t(2)-t(1);
%%%x=5*sin(2*pi*10*t)+5*sin(2*pi*35*t);
% N1=256;N2=512;w1=0.2*2*pi;w2=0.3*2*pi;w3=0.4*2*pi;
% x=(t>=-200&t<=-200+N1*deta).*sin(w1*t)+(t>-200+N1*deta&t<=-200+N2*deta).*sin(w2*t)+(t>-200+N2*deta&t<=200).*sin(w3*t);
%%%y = x;
m=0:N-1;
f=1./(N*deta)*m;%���Բ鿴�α������������������Ƶ�ʷ�Χ��
%��������Y����x(t)�ĸ���Ҷ�任��ֵ
%Y=exp(i*4*pi*f).*fft(y)%�����������Ƶ�׳���exp(i*4*pi*f)�õ�Ƶ�ƺ�[-2,2]֮���Ƶ��ֵ
Y=fft(y);
z=sqrt(Y.*conj(Y));
%%%plot(f(1:100),z(1:100));
%%%title('��Ƶ����')
xiangwei=angle(Y);
%%%figure(2)
%%%plot(f,xiangwei)
%%%title('��Ƶ����')
%%%figure(3)
%%%plot(t,y,'r')
%axis([-2,2,0,1.2])
title('ԭʼ�ź�')
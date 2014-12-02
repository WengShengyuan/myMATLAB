function [T,Tmax,p,PTmax]=Tseries(x)
%% 计算t检验统计序列的子函数
%% 参数列表
% x      时间序列，N×1列向量
% T      t检验序列，N×1列向量
% Tmax   t检验序列的最大值
% p      t检验序列最大值对应的下标
% PTmax  Tmax对应的统计显著性
%% 参数初始化
N=length(x);
T=zeros(N,1);
%% 以下是主循环，用于创建t检验序列
for i=3:(N-2)%最左边以及最右边的两个点没有对应的t检验值（或者说，其值初始化为0）
    x1=x(1:i);%序列左边部分
    N1=length(x1);%左边序列的长度
    x2=x(i:N);%序列右边部分
    N2=length(x2);%右边序列的长度
    mean_x1 = mean(x1);
    mean_x2=mean(x2);%右边部分的均值
    std_x1=std(x1);
    std_x2=std(x2);%右边部分的标准差
    %下面是计算合并偏差的公式，中英文文献里的这个公式略有不同，此处以英文文献为准
    SD=sqrt(1/N1+1/N2)*sqrt(((N1-1)*std_x1^2+(N2-1)*std_x2^2)/(N1+N2-2));
    T(i)=abs((mean_x1-mean_x2)/SD);
end
%% 计算其它三个输出参数
Tmax=max(T);%t检验序列的最大值
p=find(T==Tmax);
Eta=4.19*log(N)-11.54;%计算PTmax用的参数
Delta=0.40;%计算PTmax用的参数
v=N-2;%计算PTmax用的参数
c=v/(v+Tmax^2);%不完全B函数的下标
PTmax=(1-betainc(c,Delta*Eta,Delta));%调用不完全beta函数
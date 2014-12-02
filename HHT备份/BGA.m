function [FFLAG,AllT,AllTmax,AllPTmax]=BGA(X,P0,L0)
%% 非平稳时间序列突变检测的启发式分割算法
%% 输入参数列表
% X            待检测的数据，列向量存储
% P0           显著性水平门限值，低于此值的不再分割
% L0           最小分割尺度，子段长度小于此值的不再分割
%% 输出参数列表
% FLAG         分割点标记，列向量存储，长度与X相同
% AllT         与分割点对应的全部t检验序列，其首位数字为起点坐标
% AllTmax      与分割点对应的全部t检验序列的最大值
% AllPTmax     与分割点对应的全部t检验序列对应的统计显著性
%% 第一步：变量初始化
N=length(X);
FFLAG=zeros(N,1);
FFLAG(1)=0.1;
FFLAG(N)=0.1;
AllT=cell(0,0);
AllTmax=cell(0,0);
AllPTmax=cell(0,0);
%% 第二步：产生第一个突变点，并对序列进行分割
[T,Tmax,p,PTmax]=Tseries(X);
T=[1;T];
if PTmax<P0
    fflag=FFLAG;
    fflag(1)=0;
    fflag(N)=0;
    pos3=fflag(pos2);
    return
end
%记录输出数据
FFLAG(p)=1;
AllT=[AllT;T];
AllTmax=[AllTmax;Tmax];
AllPTmax=[AllPTmax;PTmax];
%以下为两个控制计数器
counter=2;%下一个突变点的序号
TC=0;%临时计数器
%%
while 1%设置死循环
%% 第三步：对每个段进行突变检测，能分割则分割，直到不能分割为止
    pos=find(FLAG>0);
    M=length(pos)-1;%当前子段数目
    for m=1:M
        s=pos(m);
        t=pos(m+1);
         L=length(SubX);
        if L>=L0
            [T,Tmax,p,PTmax]=Tseries(SubX);
            T=[s;T];
            if PTmax>=P0
                TC=TC+1;
                FFLAG(s+p-1)=counter;
                AllT=[AllT;T];
                AllPTmax=[AllPTmax;PTmax];
                counter=counter+1;
            end
        end
    end
%% 第四步：返回输出数据
    if TC==0
        fflag=FFLAG;
        fflag(1)=0;
        fflag(N)=0;
        pos3=fflag(pos2);
        FFLAG=[pos2,pos3];
        return
    end
%%
    TC=0;
%%
end



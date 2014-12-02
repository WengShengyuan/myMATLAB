function [FFLAG,AllT,AllTmax,AllPTmax]=BGA(X,P0,L0)
%% ��ƽ��ʱ������ͻ���������ʽ�ָ��㷨
%% ��������б�
% X            ���������ݣ��������洢
% P0           ������ˮƽ����ֵ�����ڴ�ֵ�Ĳ��ٷָ�
% L0           ��С�ָ�߶ȣ��Ӷγ���С�ڴ�ֵ�Ĳ��ٷָ�
%% ��������б�
% FLAG         �ָ���ǣ��������洢��������X��ͬ
% AllT         ��ָ���Ӧ��ȫ��t�������У�����λ����Ϊ�������
% AllTmax      ��ָ���Ӧ��ȫ��t�������е����ֵ
% AllPTmax     ��ָ���Ӧ��ȫ��t�������ж�Ӧ��ͳ��������
%% ��һ����������ʼ��
N=length(X);
FFLAG=zeros(N,1);
FFLAG(1)=0.1;
FFLAG(N)=0.1;
AllT=cell(0,0);
AllTmax=cell(0,0);
AllPTmax=cell(0,0);
%% �ڶ�����������һ��ͻ��㣬�������н��зָ�
[T,Tmax,p,PTmax]=Tseries(X);
T=[1;T];
if PTmax<P0
    fflag=FFLAG;
    fflag(1)=0;
    fflag(N)=0;
    pos3=fflag(pos2);
    return
end
%��¼�������
FFLAG(p)=1;
AllT=[AllT;T];
AllTmax=[AllTmax;Tmax];
AllPTmax=[AllPTmax;PTmax];
%����Ϊ�������Ƽ�����
counter=2;%��һ��ͻ�������
TC=0;%��ʱ������
%%
while 1%������ѭ��
%% ����������ÿ���ν���ͻ���⣬�ָܷ���ָֱ�����ָܷ�Ϊֹ
    pos=find(FLAG>0);
    M=length(pos)-1;%��ǰ�Ӷ���Ŀ
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
%% ���Ĳ��������������
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



function [finalaveimf] = eemd(Y,times,Nbits)

lvyous = Y;
Ylength = length(Y);
for i = 1 : times
    lvyous(:,i)=Y;
end

%白噪声
for i = 1: times
    for t = 1: Ylength
        lvyous(t,i) = lvyous(t,i) + randn(1,1) * Nbits;
    end
end

%对序列组进行EMD分解
[MM,NN]=size(emd(lvyous(:,1)));
imfs = zeros(10,NN,times);
for i = 1 : times
    tempimf = emd(lvyous(:,i));
    [tMM,tNN]=size(tempimf);
    if tMM < 10
        for t = (tMM+1) : 10
            tempimf(t,:)=rot90(zeros(1,tNN));
        end
    end
    imfs(:,:,i) = tempimf;
end
stopline =0;
[IMFHeight,IMFWidth] = size(imfs(:,:,1));


%对IMF求平均
for i = 1: IMFHeight
    for t = 1 : IMFWidth
        aveimf(i,t) = mean(imfs(i,t,:));
    end
end

for ci = 1: IMFHeight
     if aveimf(ci,:) == zeros(1,IMFWidth),stopline = ci,break,end
end

for i = 1: stopline-1
    for t = 1 : IMFWidth
        finalaveimf(i,t) = aveimf(i,t);
    end
end


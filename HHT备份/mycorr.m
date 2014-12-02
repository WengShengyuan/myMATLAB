function [corrs] = mycorr(Y, imfs)
[height,width] = size(imfs);
for i = 1 : height
   
    corrs(i) = corr(Y, rot90(imfs(i,:)));
end
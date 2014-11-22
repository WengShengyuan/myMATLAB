function nt3 = nsp3d(dat1,dat2,nnz,min_w,max_w,x0,x1)

% The function NSP3D plots a 3-D improved HHT spectrum in the form of 2-D spectrum slices.
% Note: for y-direction: nt=nsp3d(cy,yc,nnz,min_w,max_w,y0,y1)
%
% Non MATLAB Library function used is: NSPABE.
%
% Calling sequence-
% nt3 = nsp3d(dat1,dat2,nnz,min_w,max_w,x0,x1)
%
% Input-
%	dat1	- the matrix in x-direction resulted from sift2da
%	dat2	- the array resulted from sift2da
%	nnz	- omega-axis resolution
%	min_w	- minimum frequency
%	min_w	- maximum frequency
%	x0	- start time
%	x1	- end time
% Output-
%	nt3	- 3-D spectrum image

ny=length(dat2);        %-------------make ay axis array

dd=dat1(1:dat2(1)-2,:);dd=dd';
nt=nspabe(dd,nnz,min_w,max_w,x0,x1);
[aa,nx]=size(nt);		%--------initiate nt3
nt3=zeros(nnz*ny,nx);


for i=1:ny	%-----------nsp each slice
   i
   k1=sum(dat2(1:i));
   k0=k1-dat2(i)+1;
   k1=k1-2;
%   if( i==1) 
%	k1=k1-1;
%   end
   dd=dat1(k0:k1,:);dd=dd';
   nt=nspabe(dd,nnz,min_w,max_w,x0,x1);
   nt3(nnz*(i-1)+1:nnz*i,:)=nt;
end

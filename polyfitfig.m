function [C,k,polyfitfigure] = polyfitfig(c1,u)
orig = zeros(260,260);
c1=[c1(2,:);c1(1,:)];
[a,b]=find(c1==0 | c1 > 260);
c1(:,b)=[];
% for i=1:size(c1,2)
%     if(c1(1,i)==0 || c1(1,i) > 200 || c1(2,i)==0 || c1(2,i) > 200)
%         c1(:,i)=[];
%     end;
% end;

for i=1:size(c1,2)
    orig(round(c1(1,i)),round(c1(2,i)))=1;
end

%figure,imshow(orig);
step=30;
polyfitfigure=zeros(size(u));
k=[];
for i=1:floor(size(c1,2)/step)
    b=polyfit(c1(1,(i-1)*step+1:i*step),c1(2,(i-1)*step+1:i*step),3);
    yy=polyval(b,c1(1,(i-1)*step+1:i*step));
    dy=3*b(1,1)*c1(1,(i-1)*step+1:i*step).^2 + 2*b(1,2)*c1(1,(i-1)*step+1:i*step) + b(1,3);
    dyy = 6*b(1,1)*c1(1,(i-1)*step+1:i*step) + 2*b(1,2);
    tmpk=abs(dyy./(1+dy.^2).^1.5);
    %tmpk=ones(size(tmpk)).*mean(tmpk);
    k=[k,tmpk];
    
%     for j=1:step
%         polyfitfigure(round(c1(1,(i-1)*step+j)),round(yy(1,j)))=1;
%     end;
%     figure,imshow(polyfitfigure);
end;
tail = floor(size(c1,2)/step)*step+1;
b=polyfit(c1(1,tail:end),c1(2,tail:end),3);
yy=polyval(b,c1(1,tail:end));
dy=3*b(1,1)*c1(1,tail:end).^2 + 2*b(1,2)*c1(1,tail:end) + b(1,3);
dyy = 6*b(1,1)*c1(1,tail:end) + 2*b(1,2);
tmpk=abs(dyy./(1+dy.^2).^1.5);
%tmpk=ones(size(tmpk)).*mean(tmpk);
k=[k,tmpk];

[a,b]=find(isnan(k));
k(:,b)=[];
c1(:,b)=[];

for i=1:size(c1,2)
    polyfitfigure(round(c1(1,i)),round(c1(2,i)))=abs(k(1,i).^4*120)*(-1);
end
w=fspecial('gaussian',[5 5],1);
polyfitfigure=imfilter(polyfitfigure,w);
%figure,imagesc(polyfitfigure);
C=c1;
end


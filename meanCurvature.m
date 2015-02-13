function line = meanCurvature(u)
    C=zeros(size(u));
   [c1,h]=contour(u,[0 0]);
   
   dy=gradient(c1(2,:))./gradient(c1(1,:));
    dyy=gradient(dy)./gradient(c1(1,:));
    rho= abs(dyy)./(1+dy.^2).^(3/2);
   for i=1:size(c1,2)
       x=round(c1(1,i));
       y=round(c1(2,i));
       if x>0 && x<size(u,2) && y>0 && y<size(u,1)
       C(y,x)=255;
       end
   end
    figure,imshow(C);
   [x,y]=find(C==255);
   C=zeros(size(u));
   distance=zeros(size(x),size(x));
   for i=1:size(x)
       for j=1:size(x)
            distance(i,j)=(x(i)-x(j))^2+(y(i)-y(j))^2;
       end
   end
   curvature=zeros(size(x));
   for i=1:size(x)      
           [after,before]=sort(distance(i,:));
           min1=[x(before(2)),y(before(2))];
           min2=[x(before(3)),y(before(3))];
           dy=(min1(1,2)-min2(1,2))/(min1(1,1)-min2(1,1));
           dyy=2*((min1(1,2)-y(i))/(min1(1,1)-x(i))-(y(i)-min2(1,2))/(x(i)-min2(1,1)))/(min1(1,1)-min2(1,1));
           curvature(i)=abs(dyy/(1+dy^2)^1.5);      
   end
  for i=1:size(x)
      C(x(i),y(i))=curvature(i);
  end
    line=C;
end
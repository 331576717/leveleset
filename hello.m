function rho=hello(R)
img=zeros(100,100);
centerx=50;
centery=50;
R=20;
alpha=0:pi/50:2*pi;%½Ç¶È[0,2*pi] 
%R=2;%°ë¾¶ 
x=centerx+R*cos(alpha); 
y=centery+R*sin(alpha); 

for i=1:size(x,2)
    img(round(x(i)),round(y(i)))=1;
end
figure(),imshow(img);
dx=gradient(x);
dy=gradient(y);
hold on
quiver(0:5:100,0:5:100,dx,dy)
dy=gradient(y)./gradient(x);
dyy=gradient(dy)./gradient(x);
rho= abs(dyy)./(1+dy.^2).^(3/2)
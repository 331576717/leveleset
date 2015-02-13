function ftt=curv(f)
% calculate the curvature of f
[m,n]=size(f);
% for every front point
Dx_minus=zeros(m,n);
% Dx_plus=Dx_minus;
% Dy_minus=Dx_minus;
% Dy_pluse=Dx_minus;
Dx_central=Dx_minus;
Dy_central=Dx_minus;
Dxx=Dx_minus;
Dyy=Dx_minus;
Dxy1=Dx_minus;
Dxy2=Dx_minus;
curv=Dx_minus;

% Dx_minus(2:m-1,:)=f(2:m-1,:)-f(1:m-2,:);
% Dx_plus(2:m-1,:)=f(3:m,:)-f(2:m-1,:);
% 
% Dy_minus(:,2:n-1)=f(:,2:n-1)-f(:,1:n-2);
% Dy_plus(:,2:n-1)=f(:,3:n)-f(:,2:n-1);

Dx_central(2:m-1,2:n-1)=(f(3:m,2:n-1)-f(1:m-2,2:n-1))/2;
Dy_central(2:m-1,2:n-1)=(f(2:m-1,3:n)-f(2:m-1,1:n-2))/2;

Dxx(2:m-1,:)=f(3:m,:)+f(1:m-2,:)-2*f(2:m-1,:);
Dyy(:,2:n-1)=f(:,3:n)+f(:,1:n-2)-2*f(:,2:n-1);

% calculate the 2 parital derivature;
Dxy1(2:m-1,2:n-1)=(f(3:m,3:n)+f(1:m-2,1:n-2))/4;
Dxy2(2:m-1,2:n-1)=(f(1:m-2,3:n)+f(3:m,1:n-2))/4;
Dxy=Dxy1-Dxy2;

Grad=(Dx_central.*Dx_central +Dy_central.*Dy_central);
% calculate the curvature;
K_top = Dxx.* Dy_central.*Dy_central -  2 * Dx_central .* Dy_central .* Dxy  + Dyy .* Dx_central.*Dx_central;
K_bot = Grad+(Grad==0);

%y=exp(Grad./0.3);da=max(y(:));xiao=min(y(:));y=(y-xiao)/(da-xiao);plot(x,y);

ftt=K_top./K_bot;
%s=1./sqrt(1+K_bot);
%s=3.*sqrt(K_bot);
%utt=curv.*s;
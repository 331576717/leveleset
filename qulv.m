%������
clc; clear all; close all;
x0 = linspace(0, 1);
y0 = sin(x0).*cos(x0);
h = abs(diff([x0(2), x0(1)]));
% ģ��һ�׵�
figure; box on; hold on;
ythe1 = cos(x0).^2 - sin(x0).^2; %����һ�׵�
yapp1 = gradient(y0, h); %matlab��ֵ����
plot(x0, ythe1, '.');
plot(x0, yapp1, 'r');
legend('����ֵ', 'ģ��ֵ');
title('ģ��һ�׵�');
% ģ����׵�
figure; box on; hold on;
ythe2 = (-4)*cos(x0).*sin(x0); %���۶��׵�
yapp2 = 2*2*del2(y0, h); %matlab��ֵ����
plot(x0, ythe2,'.');
plot(x0, yapp2,'r');
legend('����ֵ', 'ģ��ֵ');
title('ģ����׵�');
% ģ������
syms x y
y = sin(x)*cos(x);
yd2 = diff(y, 2);
yd1 = diff(y, 1);
k = abs(yd2)/(1+yd1^2)^(3/2);
k1 = subs(k, x, x0);
k2 = abs(yapp2)./(1+yapp1.^2).^(3/2);
figure; box on; hold on;
plot(x0, k1, '.');
plot(x0, k2, 'r');
legend('����ֵ', 'ģ��ֵ', 'Location', 'NorthWest');
title('ģ������');

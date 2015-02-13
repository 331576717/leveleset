%求曲率
clc; clear all; close all;
x0 = linspace(0, 1);
y0 = sin(x0).*cos(x0);
h = abs(diff([x0(2), x0(1)]));
% 模拟一阶导
figure; box on; hold on;
ythe1 = cos(x0).^2 - sin(x0).^2; %理论一阶导
yapp1 = gradient(y0, h); %matlab数值近似
plot(x0, ythe1, '.');
plot(x0, yapp1, 'r');
legend('理论值', '模拟值');
title('模拟一阶导');
% 模拟二阶导
figure; box on; hold on;
ythe2 = (-4)*cos(x0).*sin(x0); %理论二阶导
yapp2 = 2*2*del2(y0, h); %matlab数值近似
plot(x0, ythe2,'.');
plot(x0, yapp2,'r');
legend('理论值', '模拟值');
title('模拟二阶导');
% 模拟曲率
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
legend('理论值', '模拟值', 'Location', 'NorthWest');
title('模拟曲率');

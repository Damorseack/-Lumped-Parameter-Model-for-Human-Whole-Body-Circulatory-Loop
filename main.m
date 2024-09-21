clear;
close all;
clc;
% profile on
%心血管系统微分方程求解
tspan=0:0.001:2.4;
x0=[6.9;9.6;67;80;0]; 
[t1,x1]=ode45(@odefun8,tspan,x0);
plot(t1,x1(:,[1,4]))
xlabel('时间/s')
ylabel('压力/mmHg')
    
  
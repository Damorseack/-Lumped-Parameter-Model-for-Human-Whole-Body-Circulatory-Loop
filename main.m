clear;
close all;
clc;
% profile on
%��Ѫ��ϵͳ΢�ַ������
tspan=0:0.001:2.4;
x0=[6.9;9.6;67;80;0]; 
[t1,x1]=ode45(@odefun8,tspan,x0);
plot(t1,x1(:,[1,4]))
xlabel('ʱ��/s')
ylabel('ѹ��/mmHg')
    
  
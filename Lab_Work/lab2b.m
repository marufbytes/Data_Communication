clc;
clear;
close all;

% ID 23-54391-3
E = 9; F = 1; G = 3;

a1 = G + 1;  
a2 = F + 2;  
a3 = E + 3;   

f1 = E + 1;  
f2 = F + 2;  
f3 = G + 3;  

fs = 1000;
t = 0:1/fs:1;

% Signal
x1 = a1*cos(2*pi*f1*t);
x2 = a2*sin(2*pi*f2*t);
x3 = a3*cos(2*pi*f3*t);

signal_x = x1 + x2 + x3;

f0 = gcd(gcd(f1,f2),f3);  
T0 = 1/f0;

t1 = 0:1/fs:T0;
x_cycle = a1*cos(2*pi*f1*t1) + ...
          a2*sin(2*pi*f2*t1) + ...
          a3*cos(2*pi*f3*t1);

xmin = min(x_cycle);
xmax = max(x_cycle);

L = 4; 
partition = linspace(xmin, xmax, L+1);
partition = partition(2:end-1); 

codebook = linspace(xmin, xmax, L); 

[index, xq] = quantiz(x_cycle, partition, codebook);

figure;

subplot(2,1,1)
plot(t1, x_cycle, 'LineWidth',1.5)
title('Original Signal (One Cycle)')
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0 T0])
grid on

subplot(2,1,2)
stairs(t1, xq, 'r','LineWidth',1.5)
title('4-Level Quantized Signal')
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0 T0])
grid on

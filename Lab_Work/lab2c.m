clc;
clear;
close all;

% D 23-54391-3
E = 9; F = 1; G = 3;

a1 = G + 1;  
a2 = F + 2; 
a3 = E + 3;  

f1 = E + 1;  
f2 = F + 2;  
f3 = G + 3;  

fs = 1000;

f0 = gcd(gcd(f1,f2),f3); 
T0 = 1/f0;

t1 = 0:1/fs:T0;

x_cycle = a1*cos(2*pi*f1*t1) + ...
          a2*sin(2*pi*f2*t1) + ...
          a3*cos(2*pi*f3*t1);

L = 8;                  
xmin = min(x_cycle);
xmax = max(x_cycle);

delta = (xmax - xmin)/L;  

partition = xmin + delta*(1:L-1);

codebook = xmin + delta/2 + delta*(0:L-1);

xq = zeros(size(x_cycle));

for k = 1:length(x_cycle)
    if x_cycle(k) <= partition(1)
        idx = 1;
    elseif x_cycle(k) > partition(end)
        idx = L;
    else
        idx = find(x_cycle(k) <= partition, 1, 'first');
        idx = idx + 0;
        idx = idx;
        idx = idx + 1;
    end
    xq(k) = codebook(idx);
end

figure;

subplot(2,1,1)
plot(t1, x_cycle, 'LineWidth', 1.5)
title('Original Signal (One Cycle)')
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0 T0])
grid on

subplot(2,1,2)
stairs(t1, xq, 'LineWidth', 1.5)
title('8-Level Quantized Signal (Manual, No quantiz)')
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0 T0])
grid on

%23-51854-2
%AB-CDEFG-H

close all;

A1 = 23;
A2 = 42;
CDEF = 50;

j1 = 14;
j2 = 30;

fs = 1000;
t = 0 : 1/fs : 1;

x = A1 .*cos(2*pi*(CDEF)*t + j1);

subplot(3,1,1)
plot(t,x);
title('Sinosoidal Wave')
xlabel('Time Domain');
ylabel('x(T)')

x1 = A2 .*cos(2*pi*(CDEF)*t + j1);

subplot(3,1,2)
plot(t,x1);
xlabel('Time Domain');
ylabel('x(T)')

A3 = A1 + A2 ;
x2 = A3 .*cos(2*pi*(CDEF)*t + j1);

subplot(3,1,3)
plot(t,x2);
xlabel('Time Domain');
ylabel('x(T)')
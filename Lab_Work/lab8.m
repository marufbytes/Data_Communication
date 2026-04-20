clc;
clear;
close all;

Am1=10; 
Am2=20; 
Am3=30;

Ac1=40; 
Ac2=50; 
Ac3=60;

fm1=5; 
fm2=7; 
fm3=9;

fc1=50; 
fc2=60; 
fc3=70;

fs=5000;
t=0:1/fs:1;

m1=Am1*sin(2*pi*fm1*t);
m2=Am2*sin(2*pi*fm2*t);
m3=Am3*sin(2*pi*fm3*t);

c1=Ac1*sin(2*pi*fc1*t);
c2=Ac2*sin(2*pi*fc2*t);
c3=Ac3*sin(2*pi*fc3*t);

figure;

subplot(4,1,1);
plot(t,m1);
title('Message signal 1');
grid on;

subplot(4,1,2);
plot(t,m2);
title('Message signal 2');
grid on;

subplot(4,1,3);
plot(t,m3);
title('Message signal 3');
grid on;

x=(c1.*m1)+(c2.*m2)+(c3.*m3);

subplot(4,1,4);
plot(t,x);
title('Composite signal');
grid on;

[a,b]=butter(5,[(fc1-fm1-6)/(fs/2),(fc1+fm1+6)/(fs/2)]);
bpf1=filter(a,b,x);

[c,d]=butter(5,[(fc2-fm2-6)/(fs/2),(fc2+fm2+6)/(fs/2)]);
bpf2=filter(c,d,x);

[e,f]=butter(5,[(fc3-fm3-6)/(fs/2),(fc3+fm3+6)/(fs/2)]);
bpf3=filter(e,f,x);

z1 = 2*bpf1.*c1;
z2 = 2*bpf2.*c2;
z3 = 2*bpf3.*c3;

[g,h]=butter(5,(fm1+3)/(fs/2));
rec1=filter(g,h,z1);

[i,j]=butter(5,(fm2+3)/(fs/2));
rec2=filter(i,j,z2);

[k,l]=butter(5,(fm3+3)/(fs/2));
rec3=filter(k,l,z3);

figure;

subplot(3,1,1);
plot(t,rec1);
title('Received Signal 1');
grid on;

subplot(3,1,2);
plot(t,rec2);
title('Received Signal 2');
grid on;

subplot(3,1,3);
plot(t,rec3);
title('Received Signal 3');
grid on;
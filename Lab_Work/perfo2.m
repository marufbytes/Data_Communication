clc;
clear;
close all;

Am1=10;
Am2=20;
Am3=30;

Ac1=40;
Ac2=50;
Ac3=60;

fm1=4;
fm2=5;
fm3=6;


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

subplot(4,1,1);
plot(t,m1)
title('Messege Signal 1');

subplot(4,1,2);
plot(t,m2)
title('Messege Signal 2');

subplot(4,1,3);
plot(t,m3)
title('Messege Signal 3');

com=(c1.*m1)+(c2.*m2)+(c3.*m3);

subplot(4,1,4);
plot(t,com)
title('composite Signal 3');
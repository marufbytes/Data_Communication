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


fc1=100;
fc2=170;
fc3=250;

fs=5000;
t=0:1/fs:1;

m1=Am1*sin(2*pi*fm1*t);
m2=Am2*sin(2*pi*fm2*t);
m3=Am3*sin(2*pi*fm3*t);

c1=Ac1*sin(2*pi*fc1*t);
c2=Ac2*sin(2*pi*fc2*t);
c3=Ac3*sin(2*pi*fc3*t);

com=(c1.*m1)+(c2.*m2)+(c3.*m3);


[a,b] = butter(5,[(fc1-fm1-6)/(fs/2),(fc1+fm1+6)/(fs/2)]);
bpf1=filter(a,b,com);

[c,d] = butter(5,[(fc2-fm2-6)/(fs/2),(fc2+fm2+6)/(fs/2)]);
bpf2=filter(c,d,com);

[e,f] = butter(5,[(fc3-fm3-6)/(fs/2),(fc3+fm3+6)/(fs/2)]);
bpf3=filter(e,f,com);

z1=2*bpf1.*c1;
z2=2*bpf2.*c2;
z3=2*bpf3.*c3;



[g,h]= butter(5,(fm1+3)/(fs/2));
rec1=filter(g,h,z1);


[i,j]= butter(5,(fm2+3)/(fs/2));
rec2=filter(i,j,z2);

[k,l]= butter(5,(fm3+3)/(fs/2));
rec3=filter(k,l,z3);


subplot(3,1,1);
plot(t,rec1)
title('received Signal 1');

subplot(3,1,2);
plot(t,rec2)
title('received Signal 2');

subplot(3,1,3);
plot(t,rec3)
title('received  Signal 3');
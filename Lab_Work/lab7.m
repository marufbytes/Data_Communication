clc;
clear;
close all;

Am=10;
Ac=20;
fm=5;
fc=50;
fs=5000;
t=0:1/fs:1;

m=Am*sin(2*pi*fm*t);
c=Ac*sin(2*pi*fc*t);

subplot(4,1,1);
plot(t,m);
title('Message signal');

subplot(4,1,2);
plot(t,c);
title('Carry Signal');

mu = Am/Ac;
s=(Ac+m).*sin(2*pi*fc*t);
subplot(4,1,3);
plot(t,s);
title('Modulated Signal');


am_demodulated=s.*c;
[a,b]=butter(6,(60).*2/fs);
demod_signal=filtfilt(a,b,(am_demodulated-200)./10);
subplot(4,1,4);
plot(t,demod_signal);
title('Demodulated signal')


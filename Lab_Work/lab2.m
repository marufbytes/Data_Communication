%23-54391-3

close all;
a1 = 5;
a2 = 4;
a3 = 3;

f1 = 9;
f2 = 1;
f3 = 4;   

fs = 1000;
t = 0 : 1/fs : 1;

x1 = a1.*cos(2*pi*f1*t);
x2 = a2.*sin(2*pi*f2*t);
x3 = a3.*cos(2*pi*f3*t);

x = x1 +  x2 + x3;
n = 5.*randn(size(x));

nx = x + n;
%x1
subplot(5,2,1);
plot(t,x1);
title('COMPOSITE SIGNAL');
xlabel('Amplitude');
ylabel('Time Domain');

%x2
subplot(5,2,3);
plot(t,x2);


%x3
subplot(5,2,5);
plot(t,x3);


%x
subplot(5,2,7);
plot(t,x);


%nx
subplot(5,2,9);
plot(t,nx);



bw = obw(x,fs);

%f = linspace(-1,1,fs).*(fs/2);
N = length(x);                 % correct number of samples
f = linspace(-fs/2, fs/2, N);


fx1 = fft(x1);
fx1 = fftshift((fx1)/(fs/2));
%subplot(5,2,2);
%plot(f,abs(fx1));
%axis = ([-50 50 0 5]);


fx2 = fft(x2);
fx2 = fftshift((fx2)/(fs/2));
%subplot(5,2,4);
%plot(f,abs(fx2));

fx3 = fft(x3);
fx3 = fftshift((fx3)/(fs/2));
%subplot(5,2,6);
%plot(f,abs(fx3));

fx = fft(x);
fx = fftshift((fx)/(fs/2));
%subplot(5,2,8);
%plot(f,abs(fx));

fnx = fft(nx);
fnx = fftshift((fnx)/(fs/2));
%subplot(5,2,10);
%plot(f,abs(fnx));

subplot(5,2,2);
plot(f,abs(fx1));
title('FFT of x1');
xlim([-20 20]);
ylim([0 6]);

subplot(5,2,4);
plot(f,abs(fx2));
title('FFT of x2');
xlim([-20 20]);
ylim([0 8]);

subplot(5,2,6);
plot(f,abs(fx3));
title('FFT of x3');
xlim([-20 20]);
ylim([0 13]);

subplot(5,2,8);
plot(f,abs(fx));
title('FFT of Composite');
xlim([-20 20]);
ylim([0 13]);

subplot(5,2,10);
plot(f,abs(fnx));
title('FFT of Noisy Signal');
xlim([-20 20]);
ylim([0 13]);



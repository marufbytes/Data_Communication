clc; clear;
close all;

%23-51854-2
A = 2;
B=3;
C= 5;
D=1;
E=8;
F=5;
G=4;
H=2;


time_duration=0.2;
analog_t=0:0.0001:time_duration;

a=[6 8 7 9];
f=[9 11 5 6];
analog_sig = a(1)*sin(2*pi*f(1)*analog_t) + a(2)*cos(2*pi*f(2)*analog_t) + a(3)*sin(2*pi*f(3)*analog_t);

subplot(3,2,1)
plot(analog_t,analog_sig)
xlabel('Time (sec)')
ylabel ('A (volts)')
title ('Input analog signal')
grid on;

% % sampling 
fs=250;
samp_t=0:1/fs:time_duration;
samp_sig = a(1)*sin(2*pi*f(1)*samp_t) + a(2)*cos(2*pi*f(2)*samp_t) + a(3)*sin(2*pi*f(3)*samp_t);
 
subplot (3,2,2)
stem(samp_t,samp_sig)
xlabel('Time (sec)')
ylabel ('A (volts)')
title ('Samping signal')
grid on;
% 
% % quantization
nb=7;
L=2^nb-1;
delta=(max(samp_sig)-min(samp_sig))/L;
i= round ((samp_sig-min(samp_sig))/delta);
quant_sig=min(samp_sig)+i*delta;

subplot (3,2,3)
stairs(samp_t,quant_sig)
xlabel('Time (sec)')
ylabel ('A (volts)')
title ('Quantized signal')
grid on;
% 
% % encoding
dig_sig_matrix=de2bi(i,nb);
% encoded digigal signal
dig_sig=reshape (dig_sig_matrix',1,[])
% 
% % decoding
decod_index=reshape(dig_sig,nb,[])';
decod_index_dec=bi2de(decod_index);
decod_quant_sig=min(samp_sig)+decod_index_dec*delta;
% 
subplot (3,2,4)
stairs(samp_t,decod_quant_sig)
xlabel('Time (sec)')
ylabel ('A (volts)')
title ('Decoded Quantized signal')
grid on;
% 
% % error signal
er=abs(samp_sig-quant_sig)
% 
subplot(3,2,5)
plot(samp_t,er)
xlabel('Time (sec)')
ylabel ('A (volts)')
title ('Error signal')
grid on;
% 
% % Low pass filter 
fc=100;
[b,a]=butter(4,fc/(fs/2)); % Low passfilter 
recons_signal=filter(b,a,decod_quant_sig);
% 
subplot(3,2,6)
plot(samp_t,recons_signal)
xlabel ('Time (sec)')
ylabel ('A (volts)')
title ('Recovered analog signal')
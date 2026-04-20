clc; clear; close all;

% ID: 23-51854-2
A = 2; B = 3; C = 5; D = 1;
E = 8; F = 5; G = 4; H = 2;

% amplitudes
A1 = A + B + H;
A2 = B + C + H;

% noise scale
v = 0.5;

fs = 4000;
t = 0:1/fs:1-1/fs;

% frequencies
f1 = (C + D + H)*100;
f2 = (D + E + H)*100;

% signal parts
x1 = A1*sin(2*pi*f1*t);
x2 = A2*cos(2*pi*f2*t);

% noise
n = v*randn(size(t));

% final signal
signal = x1 + x2 + n;

% bandwidth
bw = obw(signal, fs);

% signal power (A^2/2 for sin/cos)
sigpow = (A1^2)/2 + (A2^2)/2;

% noise power
npow = v^2;

% SNR
snr2 = sigpow / npow;
snrdb2 = 10*log10(snr2);

% Shannon capacity
c2 = bw * log2(1 + snr2);

% levels
L2 = 2^(c2/(2*bw));

% Nyquist bit rate
BR2 = 2*bw*log2(L2);

% check condition
if (c2 <= BR2)
    disp('Correct')
else 
    disp('Not correct')
end
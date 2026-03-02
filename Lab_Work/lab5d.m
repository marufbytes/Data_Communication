% Unipolar NRZ
clc;
clear all;
close all;

% E = 8 = 1000
% F = 5 = 0101
% G = 4 = 0100
bit_stream = [1 0 0 0 0 1 0 1 0 1 0 0];
no_bits = length(bit_stream); %no_bit=8
bit_rate = 1000; % 1 kbps
pulse_per_bit = 1; % for unipolar nrz
pulse_duration = 1/((pulse_per_bit)*(bit_rate)); %pulse_duration=1/1*1000=1x10-3 (second)=1 ms
no_pulses = no_bits*pulse_per_bit; %no_pulses=8*1=8

samples_per_pulse = 500;
fs = (samples_per_pulse)/(pulse_duration); %sampling frequency
t = 0:1/fs:(no_pulses)*(pulse_duration); % sampling interval, total duration = (no_pulse)*(pulse_duration)
no_samples = length(t); % no_samples=4001 
dig_sig = zeros(1,no_samples); % intial digital signal (line coded signal according to unipolor nrz)
max_voltage = 5;
nuetral = 0;
min_voltage = -5;
%min_voltage=-5;
last_polarity = max_voltage;
for i = 1:length(bit_stream)
    if bit_stream(i) == 0
        dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = nuetral*ones(1,samples_per_pulse);
    else
        last_polarity = -last_polarity;
       dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = last_polarity*ones(1,samples_per_pulse);
    end
end

plot(t,dig_sig)
grid on
xlabel('time in seconds')
ylabel('Voltage')
ylim([(min_voltage - (max_voltage)*0.2) (max_voltage+max_voltage*0.2)])
title(['Unipolar NRZ for ',num2str(bit_stream),''])

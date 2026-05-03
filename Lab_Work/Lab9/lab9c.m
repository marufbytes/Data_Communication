clc;
clear all;
%Eye

Transmitted_Message= 'Data Comm is fun'
% Converting Information Message to bit
x=asc2bn(Transmitted_Message); 
bp=.000001; % bit duration
disp(' Binary information at Trans mitter (x):');
disp(x); %1x24


x1 = [1 x(1:8) 0];
x2 = [1 x(9:16) 0];
x3 = [1 x(17:24) 0];
x4 = [1 x(25:32) 0];
x5 = [1 x(33:40) 0];
x6 = [1 x(41:48) 0];
x7 = [1 x(49:56) 0];
x8 = [1 x(57:64) 0];
x9 = [1 x(65:72) 0];
x10 = [1 x(73:80) 0];
x11 = [1 x(81:88) 0];
x12 = [1 x(89:96) 0];
x13 = [1 x(97:104) 0];
x14 = [1 x(105:112) 0];
x15 = [1 x(113:120) 0];
x16 = [1 x(121:128) 0];


x = [x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16];
% Representation of transmitting binary information as digital signal
bit=[]; 
for n=1:1:length(x) 
    if x(n)==1;
       se=5*ones(1,100);
    else x(n)==0;
       se=zeros(1,100);
    end
     bit=[bit se]; 
end


t1=bp/100:bp/100:100*length(x)*(bp/100); % dimension is 1x2400

subplot(4,1,1);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 6]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Transmitting information as digital signal');

% Binary-ASK modulation 
A1=5;  % Amplitude of carrier signal for information 1
A2=0;  % Amplitude of carrier signal for information 0 bit
br=1/bp;  % bp is bit duration 
f=br*10;  % carrier frequency 

t2=bp/99:bp/99:bp; % size will be 1x99                 
ss=length(t2);

m=[]; % variable m will save the samples of ASK modulated signal (Tx side)

for (i=1:1:length(x))
    if (x(i)==1)
        y=A1*cos(2*pi*f*t2);
    else
        y=A2*cos(2*pi*f*t2); 
        %y=0;
    end
    m=[m y]; % dimension of m 1x (24x99)=2376, 1x2376 (ASK modulated signal=m)
end

t3=bp/99:bp/99:bp*length(x); %Dimension of t3 is 1x2376

subplot(4,1,2);
plot(t3,m);
axis([ 0 bp*length(x) -6 6]);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('Modulated Signal at Transmitter');
disp(' Message transmitted through a Transmission medium');

% Transmitter side task is done. We have ASK modulated signal 'm'

%Channel Noise (using mathematical formula)
signal_power = mean(abs(m).^2);
snr_dB=30;
snr = 10^(snr_dB/10);
noise_power = signal_power / snr;
noise = sqrt(noise_power) * randn(size(m));

Rec=m+noise;  %ASK modulted signal with awgn noise 

subplot(4,1,3);
plot(t3,Rec);
%axis([ 0 bp*length(x) -6 6]);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('Received signal at Receiver (Adding AWGN)');

%Receiver side task started from here
% Binary ASK demodulation 

mn=[]; % ASK demodulated signal for received signal 'Rec'

for n=ss:ss:length(Rec)
  t=bp/99:bp/99:bp;
  y=cos(2*pi*f*t);  % Carrier siignal 
  mm=y.*Rec((n-(ss-1)):n); % multifying the carrier signal with received ASK modulated signal
  z=trapz(t,mm) ; % intregation 
  zz=round((2*z/bp));
  if(zz>2.5)
    a=1;
  else
    a=0;
  end
  mn=[mn a]; %1x24, equivalent to x signal at transmitter side
end
disp('Binary information at Reciver :');
disp(mn);


% Representation of binary information as digital signal which achived 
% After ASK demodulation 

bit=[];
for n=1:length(mn);
    if mn(n)==1;
       se=5*ones(1,100);
    else mn(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];
end

t5=bp/100:bp/100:100*length(mn)*(bp/100);
subplot(4,1,4)
plot(t5,bit,'LineWidth',2.5);grid on;
axis([ 0 bp*length(mn) -.5 6]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Demodulated signal at receiver');

mn=[mn(2:9) mn(12:19) mn(22:29) mn(32: 39) mn(42:49) mn(52:59) mn(62:69) mn(72:79) mn(82:89) mn(92:99) mn(102:109) mn(112:119) mn(122:129) mn(132:139) mn(142:149) mn(152:159) ]

%Converting Information bit to Message
Received_Message=bin2asc(mn)
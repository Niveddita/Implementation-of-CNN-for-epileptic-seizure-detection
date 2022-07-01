load 'data.txt';% loading data
Fs=173.61;%sampling frequency
[N1,nu]=size(data);%obtain size of data
t = (0:nu-1)/Fs;
x = data(1,:);
%% Plot Signal
% input time-domain plot of the EEG vector
figure
plot(t,x)
xlabel('Time')
ylabel('Amplitude')
title('Raw EEG signal')
%% FIR filter
%filterdata = load('EEGFIR.mat');
%FIR_hd = filterdata.Hd;
%FIR_filt = filter(FIR_hd,x);
%subplot(2,1,2)
%plot(t,FIR_filt)
%title('Output Time-Domain Waveform of EEG signal - FIR Notch Filter')
%ylabel('Amplitude (N)')
%xlabel('time (s)')
%% FIR bandpass filter
bsFilt = designfilt('bandpassfir','FilterOrder',35,'CutoffFrequency1',0.1,'CutoffFrequency2',60,'SampleRate',Fs);
fvtool(bsFilt)
%X=filtfilt(bsFilt,x); % zero phase filter
%periodogram(X(1,:), [], [], Fs); % Plot filtered data
FIR_out = filter(bsFilt,x);
figure;
plot(t,FIR_out)
%% Comparison
figure;
subplot(2,1,1)
plot(t,x)
xlabel('Time')
ylabel('Amplitude')
title('Raw EEG signal')
subplot(2,1,2)
plot(t,FIR_out)
xlabel('Time')
ylabel('Amplitude')
title('Filtered EEG signal')
%% Using filter design app
N    = 20;       % Order
Fc1  = 0.5;        % First Cutoff Frequency
Fc2  = 60;       % Second Cutoff Frequency
flag = 'scale';  % Sampling Flag

% Create the window vector for the design algorithm.
win = hamming(N+1);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, [Fc1 Fc2]/(Fs/2), 'bandpass', win, flag);
Hd1 = dfilt.dffir(b);
FIR_filt1 = filter(Hd1,x);
figure;
subplot(2,1,1)
plot(t,x)
xlabel('Time')
ylabel('Amplitude')
title('Raw EEG signal')
subplot(2,1,2)
plot(t,FIR_filt1)
xlabel('Time')
ylabel('Amplitude')
title('Filtered EEG signal')
%% dwt
waveletFunction = 'db2';
S=FIR_out;
[C,L] = wavedec(S,5,waveletFunction);
cD1 = detcoef(C,L,1);                   %NOISY
cD2 = detcoef(C,L,2);                  %Gamma
cD3 = detcoef(C,L,3);                   %Beta
cD4 = detcoef(C,L,4);                   %Alpha
cD5 = detcoef(C,L,5);                   %Delta
cA5 = appcoef(C,L,waveletFunction,5);   %Theta
figure;
subplot(6,1,1)
plot(cA5)
title('Approximation Coefficients Theta')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
subplot(6,1,2)
plot(cD5)
title('Level 5 Detail Coefficients Delta')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
subplot(6,1,3)
plot(cD4)
title('Level 4 Detail Coefficients Alpha')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
subplot(6,1,4)
plot(cD3)
title('Level 3 Detail Coefficients Beta')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
subplot(6,1,5)
plot(cD2)
title('Level 2 Detail Coefficients Gamma')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
subplot(6,1,6)
plot(cD1)
title('Level 1 Detail Coefficients Noise')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
%% spectrogram
figure;
spectrogram(cD1)
figure;
spectrogram(cD2)
figure;
spectrogram(cD3)
figure;
spectrogram(cD4)
figure;
spectrogram(cD5)
figure;
spectrogram(cA5)
%% plots
y=data(450,:);
figure;
subplot(2,1,1)
plot(t,x)
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
title('EEG signal of a healthy subject')
subplot(2,1,2)
plot(t,y,'r')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
title('EEG signal of a seizure subject')
%%
figure;
subplot(2,2,1)
plot(t,x,'b')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
title('EEG signal of a healthy subject')
subplot(2,2,2)
plot(t,abs(fft(x)),'b')
xlim([0 70])
xlabel('Frequency(Hz)')
ylabel('Amplitude(µV)')
title('FFT of EEG signal')
subplot(2,2,3)
plot(t,FIR_out,'r')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
title('Filtered EEG signal')
subplot(2,2,4)
plot(t,abs(fft(FIR_out)),'r')
xlim([0 70])
xlabel('Frequency(Hz)')
ylabel('Amplitude(µV)')
title('FFT of filtered signal')
%% 
figure;
subplot(2,2,1)
plot(t,y,'b')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
title('EEG signal of a seizure subject')
subplot(2,2,2)
plot(t,abs(fft(y)),'b')
xlim([0 70])
xlabel('Frequency(Hz)')
ylabel('Amplitude(µV)')
title('FFT of EEG signal')
FIR_out2 = filter(bsFilt,y);
subplot(2,2,3)
plot(t,FIR_out2,'r')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
title('Filtered EEG signal')
subplot(2,2,4)
plot(t,abs(fft(FIR_out2)),'r')
xlim([0 70])
xlabel('Frequency(Hz)')
ylabel('Amplitude(µV)')
title('FFT of filtered signal')
%%
waveletFunction = 'db2';
S=FIR_out2;
[C,L] = wavedec(S,5,waveletFunction);
cD1 = detcoef(C,L,1);                   %NOISY
cD2 = detcoef(C,L,2);                  %Gamma
cD3 = detcoef(C,L,3);                   %Beta
cD4 = detcoef(C,L,4);                   %Alpha
cD5 = detcoef(C,L,5);                   %Delta
cA5 = appcoef(C,L,waveletFunction,5);   %Theta
figure;
subplot(6,1,1)
plot(cA5)
title('Approximation Coefficients Theta')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
subplot(6,1,2)
plot(cD5)
title('Level 5 Detail Coefficients Delta')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
subplot(6,1,3)
plot(cD4)
title('Level 4 Detail Coefficients Alpha')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
subplot(6,1,4)
plot(cD3)
title('Level 3 Detail Coefficients Beta')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
subplot(6,1,5)
plot(cD2)
title('Level 2 Detail Coefficients Gamma')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
subplot(6,1,6)
plot(cD1)
title('Level 1 Detail Coefficients Noise')
xlabel('Time(sec)')
ylabel('Amplitude(µV)')
%% 
figure;
f=1:90;
subplot(3,2,1)
plot(f,abs(fft(cD1(1:90))))
title('Noise Signal (1-60 Hz)')
xlabel('Frequency')
ylabel('Magnitude')
f1=1:90;
subplot(3,2,2)
plot(f1,abs(fft(cD2(1:90))))
title('Gamma Sub-Band (30-60 Hz)')
xlabel('Frequency')
ylabel('Magnitude')
f2=1:45;
subplot(3,2,3)
plot(f2,abs(fft(cD3(1:45))))
title('Beta Sub-Band (13-30 Hz)')
xlabel('Frequency')
ylabel('Magnitude')
f3=1:25;
subplot(3,2,4)
plot(f3,abs(fft(cD4(1:25))))
title('Alpha Sub-Band (8-13 Hz)')
xlabel('Frequency')
ylabel('Magnitude')
f4=1:12;
subplot(3,2,5)
plot(f4,abs(fft(cD5(1:12))))
title('Theta Sub-Band (4-8 Hz)')
xlabel('Frequency')
ylabel('Magnitude')
f4=1:12;
subplot(3,2,6)
plot(f4,abs(fft(cA5(1:12))))
title('Delta Sub-Band (1-4 Hz)')
xlabel('Frequency')
ylabel('Magnitude')





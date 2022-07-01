load 'data.txt';% loading data
Fs=173.61;%sampling frequency
[N1,nu]=size(data);%obtain size of data
t = (0:nu-1)/Fs;
path1 = 'E:\MATLAB\Plots\Noise' 
for i=1:5
x = data(i,:);
%% Plot Signal
% input time-domain plot of the EEG vector
figure
plot(t,x)
xlabel('Time')
ylabel('Amplitude')
title('Raw EEG signal')
%% FIR bandpass filter
bsFilt = designfilt('bandpassfir','FilterOrder',101,'CutoffFrequency1',0.1,'CutoffFrequency2',60,'SampleRate',Fs);
fvtool(bsFilt)
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
figure;
plot(t,x)
hold on
plot(t,FIR_out,"Color",'r')
%% FFT
figure;
subplot(2,1,1)
plot(t,fft(x))
xlabel('Time')
ylabel('Amplitude')
title('Raw EEG signal-FFT')
subplot(2,1,2)
plot(t,fft(FIR_out))
xlabel('Time')
ylabel('Amplitude')
title('Filtered EEG signal-FFT')
figure;
plot(t,fft(x))
hold on
plot(t,fft(FIR_out),"Color",'r')
%% dwt
waveletFunction = 'db2';
S=FIR_out;
[C,L] = wavedec(S,5,waveletFunction);
cD1 = detcoef(C,L,1);                   %NOISY
cD2 = detcoef(C,L,2);                  %Gamma
cD3 = detcoef(C,L,3);                   %Beta
cD4 = detcoef(C,L,4);                   %Alpha
cD5 = detcoef(C,L,5);                   %Theta
cA5 = appcoef(C,L,waveletFunction,5);   %Delta
subplot(6,1,1)
plot(cA5)
title('Approximation Coefficients Delta')
xlabel('Time')
ylabel('Amplitude')
subplot(6,1,2)
plot(cD5)
title('Level 5 Detail Coefficients Theta')
xlabel('Time')
ylabel('Amplitude')
subplot(6,1,3)
plot(cD4)
title('Level 4 Detail Coefficients Alpha')
xlabel('Time')
ylabel('Amplitude')
subplot(6,1,4)
plot(cD3)
title('Level 3 Detail Coefficients Beta')
xlabel('Time')
ylabel('Amplitude')
subplot(6,1,5)
plot(cD2)
title('Level 2 Detail Coefficients Gamma')
xlabel('Time')
ylabel('Amplitude')
subplot(6,1,6)
plot(cD1)
title('Level 1 Detail Coefficients Noise')
xlabel('Time')
ylabel('Amplitude')
%% spectrogram
figure(i);
spectrogram(cD1);
temp=[path1,filesep,'noise',num2str(i),'.png'];
saveas(gca,temp);
end
%% 





[f, fs] = audioread('test.wav');
N = length(f);

%% Playing the audio
sound(f,fs);
pause(10);

%% Plot both audio channels
figure;
subplot(221);
stem(1:N, f(:,1));
title('input signal in time domain');


%% Plot the spectrum
N = size(f,1);
df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(f(:,1), N) / N; %//For normalizing, but not needed for our analysis
y2 = fftshift(y);
subplot(222);
plot(w,abs(y2)),title('input signal in frequency domain');

%% Design a lowpass filter that filters out anything after 2000 Hz
n = 7;
cutFreq = 2000 / (fs/2);
[b,a] = butter(n,  cutFreq);

%% Filter the signal
fOut = filter(b, a, f);

%% Construct audioplayer object and play
p = audioplayer(fOut, fs);
p.play;


subplot(223),stem(1:N,fOut(:,1)),title('Output signal in time domain');

y = fft(fOut(:,1), N) / N;
y2 = fftshift(y);

subplot(224),plot(w, abs(y2)),title('Output signal in frequency domain');

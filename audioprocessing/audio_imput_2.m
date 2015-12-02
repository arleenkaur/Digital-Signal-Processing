clear all;
close all;
clc;

%% Read the input
[f, fs] = audioread('input.wav');
N = length(f);

%% Playing the audio
disp('playing original sound');
player1 = audioplayer(f,fs);
play(player1);
pause(2);
stop(player1);
%sound(f,fs);
%pause(10);

%% Plot the original signal in time domain
subplot(321);
plot(1:N, f,'r'),title('Input signal in time domain');


%% Plot the spectrum
F = fft(f);
subplot(322),plot(abs(F)),title('Input signal in frequency domain');

%% Adding noise to the sound
f = f + 0.01*randn(size(f));
disp('Playing sound with noise');
player1 = audioplayer(f,fs);
play(player1);
pause(2);
stop(player1);
%sound(f,fs);
%pause(10);

audiowrite('noisy_input.wav',f,fs);

%% Plot the signal with noise in time domain
subplot(323);
plot(1:N, f,'r'),title('Noisy signal in time domain');


%% Plot the spectrum
F = fft(f);
subplot(324),plot(abs(F)),title('Noisy signal in frequency domain');

%% Design a lowpass filter that filters out anything after 2000 Hz
w = linspace(0,1*pi,N);
fc = 20000;        
wc = fc*pi/N;   

order = 1;           % filter order

filter = sqrt(1./(1+(w/wc).^(2*order)));



%% Filter the signal
%fOut = filter(b, a, f);

fOut = F'.*filter;   % filtered signal in freq domain

fOut_tim = ifft(((fOut)));
m = max(abs(fOut_tim));
M = max(real(fOut_tim));
fOut_time_normalised = m*real(fOut_tim)./M;

%% Plotting the results
subplot(325),plot(1:N, fOut_time_normalised, 'r'),title('Output signal in time domain');
subplot(326),plot(abs(fOut)),title('Output signal in frequency domain');


%% Construct audioplayer object and play
p = audioplayer(fOut_time_normalised, fs);
play(p);
audiowrite('output_20000_1.wav', fOut_time_normalised, fs);
pause(2);
stop(p);

%% Displaying the filter and frequency plots in a separate figure
figure
subplot(311),plot(abs(F)),title('Input signal');
subplot(312),plot(abs(filter)),title('Filter');
subplot(313),plot(abs(fOut)),title('Output signal');

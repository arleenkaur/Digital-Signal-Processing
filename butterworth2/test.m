
[wave,fs] = audioread('test.wav'); % read file into memory */

player = audioplayer(wave, fs);
play(player);

 pause(2.5);
 stop(player);


t = 0:1/fs:(length(wave)-1)/fs; % and get sampling frequency */
plot(t,wave);
 figure(1);
 subplot(211);
          plot(t,wave);
          title('Wave File');
          ylabel('Amplitude');
          xlabel('Length (in seconds)');

% graph it – try zooming while its up…not much visible until you do*/
n = length(wave)-1; 
f = 0:fs/n:fs;
wavefft=abs(fft(wave)); % perform Fourier Transform *

subplot(212);
          plot(f,wavefft); % plot Fourier Transform */
          xlabel('Frequency in Hz');
          ylabel('Magnitude');
          title('The Wave FFT');
          
          
[n, d] = butter(5, 0.5);
fvtool(n,d);

output = filter(n, d, wave);

player = audioplayer(wave, fs);
play(player);

 pause(2.5);
 stop(player);
 
 
figure(2);
wave = output;


subplot(211);
          plot(t,wave);
          title('Wave File (Constructed signal)');
          ylabel('Amplitude');
          xlabel('Length (in seconds)');

% graph it – try zooming while its up…not much visible until you do*/
n = length(wave)-1; 
f = 0:fs/n:fs;
wavefft = abs(fft(wave)); % perform Fourier Transform *

subplot(212);
          plot(f,wavefft); % plot Fourier Transform */
          xlabel('Frequency');
          ylabel('Magnitude');
          title('The Wave FFT (Constructed signal)');
          
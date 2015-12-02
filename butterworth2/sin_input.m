dt = 1/100; % sampling frequency
et = 4;     % length of series
t = 0:dt:et;% x axis points    

y_orig = 5*sin(2*2*pi*t);   % signal
noise = 3*sin(10*2*pi*t);   % noise
y = 5*sin(2*2*pi*t) + 3*sin(10*2*pi*t);  % signal with noise

figure(1);
subplot(411),plot(t, y_orig),title('Original signal'); grid on; axis([0 et -8 8])
subplot(412),plot(t,noise),title('Noise'); grid on; axis([0 et -8 8])
subplot(413),plot(t,y),title('Original signal with noise'); grid on; axis([0 et -8 8])


Y = fft(y);
n = size(y,2)/2;
amp_spec = abs(Y)/n;

subplot(414);
freq = (0:79)/(2*n*dt);
plot(freq,amp_spec(1:80)),title('Signal with noise in frequency domain');grid on

[a, b] = butter(5,0.1);
output = filter(a, b, y);
figure(2);
plot(t,output);
% test mulaw quant function
clc;clear;
%% signal generation

t = linspace(0,pi,1000);
x_sinu = 10*sin(2*pi*1*t) - cos(2*pi*2*t) + cos(2*pi*2*t);

fin_name = 'HBD.wav';
[x_audio,fs] = audioread(fin_name);

choice = 2;   % 1 for sinusoid , 2 for audio signal HDB.wav

switch choice
    case 1
        x = x_sinu;
    case 2
        x = x_audio';
end

%% Parameter initialization
B=2:2:6;
for i=1:length(B)
    
    y = mulaw_quant(x,B(i));
    err(i) = mean((y - x).^2);
    
    if choice ==2
        fout_name = [fin_name '_quantized_mu_Law_' num2str(B(i)) '_bits.wav'];
        audiowrite(fout_name,y,fs);
    end
    
    disp(['Quantization done for ' num2str(B(i)) ' bits with ' num2str(err(i)) ' Quantization error.']);
    
end
semilogy(B,err);title('Quantization error (\mu Law)');
xlabel('N of bits');
ylabel('Quantization error ');
grid on;
% test mu law
clc;clear;
%% signal generation
t = linspace(0,pi,1000);
choice = 2;
switch choice
    case 1
        x = sin(2*pi*1*t) - cos(2*pi*2*t) + cos(2*pi*2*t);
    case 2
        x = audioread('HBD.wav');
        x = x';
end


%% Parameter initialization
B=16;
V=round(abs(max(x))+abs(min(x))); % voltage level
meu=255;
%% Mu transform
Fx = sign(x).*log(1+meu*abs(x))./log(1+meu);
%% Quantize the transformation
Fx_quant = uniquant(Fx,B,V);
%% inverse transform
F_inv_quant = sign(Fx_quant).*(1/meu).*((1+meu).^(abs(Fx_quant))-1);

%% Plot the outputs
subplot(221);
plot(x);title('Orignal signal');
subplot(222);
plot(Fx);title('Mu transformed');
subplot(223);
plot(Fx_quant);title('Mu transformed quantized');
subplot(224);
plot(F_inv_quant);title('Inverse mu transformed quantized');
err = mean((F_inv_quant - x).^2);
disp(['Quantization error:' num2str(err)]);
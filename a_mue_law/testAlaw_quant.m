% test mu law
clc;clear;
%% signal generation
t = linspace(0,pi,1000);
choice = 2;
switch choice
    case 1
    x = 10*sin(2*pi*1*t) - cos(2*pi*2*t) + cos(2*pi*2*t);
    case 2
        x = audioread('HBD.wav');
        x = x';
end
%% Parameter initialization
B=64;
V=round(abs(max(x))+abs(min(x))); % voltage level

%% A transform
A=87.56;
x1= x/max(abs(x));   % normalize
% x1=x;
for i=1:length(x1)
    if abs(x1(i))>=0 && abs(x1(i))<1/A
        Fx(i)=sign(x1(i))*A*abs(x1(i))./(1+log(A));
    else
        Fx(i)=sign(x1(i))*(1+log(A*abs(x1(i))))./(1+log(A));
    end
end

%% Quantize the transformation
Fx_quant = uniquant(Fx,B,V);
%% inverse transform
for j=1:length(Fx_quant)
    if abs(Fx_quant(j))>=0 && abs(Fx_quant(j))< 1/(1+log(A))
        F_inv_quant(j) = sign(Fx_quant(j))*abs(Fx_quant(j))*(1+log(A))/A;
        
    else
        F_inv_quant(j) = sign(Fx_quant(j))*exp(abs(Fx_quant(j))*(1+log(A))-1)/(A*(1+log(A)));
    end
end

F_inv_quant = F_inv_quant*1/max(abs(F_inv_quant))*max(abs(x));   % scaling

%% Plot the outputs
subplot(221);
plot(x);title('Orignal signal');
subplot(222);
plot(Fx);title('A transformed');
subplot(223);
plot(Fx_quant);title('A transformed quantized');
subplot(224);
plot(F_inv_quant);title('Inverse A transformed quantized');
err = mean((F_inv_quant - x).^2);
disp(['Quantization error:' num2str(err)]);
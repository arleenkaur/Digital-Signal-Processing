% mu law Function

function out_seq = mulaw_quant(x,B)
V=round(abs(max(x))+abs(min(x))); % voltage level
meu=255;
%% Mu transform
x1= x/max(abs(x));
% x1=x;
Fx = sign(x1).*log(1+meu*abs(x1))./log(1+meu);
%% Quantize the transformation
Fx_quant = uniquant(Fx,B,V);
%% inverse transform
F_inv_quant = sign(Fx_quant).*(1/meu).*((1+meu).^(abs(Fx_quant))-1);
F_inv_quant = F_inv_quant*max(abs(x));
out_seq = F_inv_quant;
end
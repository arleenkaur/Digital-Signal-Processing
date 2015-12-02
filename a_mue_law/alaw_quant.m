
function out_seq = alaw_quant(x,B)

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
out_seq = F_inv_quant;
end
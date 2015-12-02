function [tnew,rnew]=LloydMax(u,pu,t,r)

% Lloyd-Max quantizer subroutine
% Computes new quantization thresholds given old ones
% Takes input (u,pu,t,r)

M=length(r);        % Number of quantization levels

tceil=0;

tnew=zeros(1,M+1);
rnew=zeros(1,M);

tnew(1)=t(1);   tnew(M+1)=t(M+1);

for k=1:M

    tfloor=tceil+1;
    tceil=min( max(find( u<=t(k+1) )),length(u) );
    
    currentu=u(tfloor:tceil);
    currentpu=pu(tfloor:tceil);
    currentnum=tceil-tfloor+1;
    
    rnew(k)= sum(currentu.*currentpu) / sum(currentpu);

    clear currentu currentpu currentnum;
end

for p=2:M
    tnew(p)= (r(p-1)+r(p)) / 2 ;
end

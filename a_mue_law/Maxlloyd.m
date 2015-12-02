% DIP HW#2 Prob 1 Bonus
% Lloyd-Max Quantizer for Triangular distribution

clear;

N=20;      % Number of iterations
M=2001;    % Number of samples along u axis

% pdf construction
u=zeros(1,M);
u=[-1:2/(M-1):1];
pu=zeros(1,M);
pu(1:(M-1)/2+1)=1+u(1:(M-1)/2+1);
pu((M-1)/2+1:M)=1-u((M-1)/2+1:M);

% Quantization data: thresholds and reconstruction levels

t=zeros(N,5);
t(:,1)=-1;  t(:,3)=0;  t(:,5)=1;
r=zeros(N,4);

% Iteration: Start with the levels obtained from the compandor

MSE=zeros(1,N);

t(1,2)=-1+1/sqrt(2);    t(1,4)=1-1/sqrt(2);

r(1,1)=-0.5;           r(1,2)=-1+sqrt(3)/2;
r(1,3)=1-sqrt(3)/2;     r(1,4)=0.5;

MSE(1)=MSECompute(u,pu,squeeze(t(1,:)),squeeze(r(1,:)));

for k=1:N-1     % kth iteration
   
    [tnew,rnew]=LloydMax( u,pu,squeeze(t(k,:)),squeeze(r(k,:)) );
    
    t(k+1,:)=tnew;
    r(k+1,:)=rnew;
    
    clear tnew rnew;
    
    MSE(k+1)=MSECompute(u,pu,squeeze(t(k+1,:)),squeeze(r(k+1,:)));
    
end
% DIP HW#2 Prob 1 Bonus
% Lloyd-Max Quantizer for Triangular distribution

clear;

N=20;      % Number of iterations
M=2001;    % Number of samples along u axis

% pdf construction
u=zeros(1,M);
u=[-1:2/(M-1):1];
pu=zeros(1,M);
pu(1:(M-1)/2+1)=1+u(1:(M-1)/2+1);
pu((M-1)/2+1:M)=1-u((M-1)/2+1:M);

% Quantization data: thresholds and reconstruction levels

t=zeros(N,5);
t(:,1)=-1;  t(:,3)=0;  t(:,5)=1;
r=zeros(N,4);

% Iteration: Start with the levels obtained from the compandor

MSE=zeros(1,N);

t(1,2)=-1+1/sqrt(2);    t(1,4)=1-1/sqrt(2);

r(1,1)=-0.5;           r(1,2)=-1+sqrt(3)/2;
r(1,3)=1-sqrt(3)/2;     r(1,4)=0.5;

MSE(1)=MSECompute(u,pu,squeeze(t(1,:)),squeeze(r(1,:)));

for k=1:N-1     % kth iteration
   
    [tnew,rnew]=LloydMax( u,pu,squeeze(t(k,:)),squeeze(r(k,:)) );
    
    t(k+1,:)=tnew;
    r(k+1,:)=rnew;
    
    clear tnew rnew;
    
    MSE(k+1)=MSECompute(u,pu,squeeze(t(k+1,:)),squeeze(r(k+1,:)));
    
end

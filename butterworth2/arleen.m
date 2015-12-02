clear all;
close all;
clc;


omega1 = pi/10; %input('First digital cutoff frequency: ');
omega2 = 9*pi/10; %input('Second digital cutoff frequency: ');

A1 = 0.9; %input('Gain at pass band frequency: ');
A2 = 0.1; %input('Gain at stop band frequency: ');

T = 1; %input('Sampling period: ');

% bilinear transformation of frequencies
OMEGA1 = (2/T) * tan(omega1/2);
OMEGA2 = (2/T) * tan(omega2/2);

% computing the order of the filter
N = (1/2)*((log10((1/A2^2 - 1)/(1/A1^2 - 1)))/(log10(OMEGA2/OMEGA1)));
N = ceil(N);

% computing analog cutoff frequency
OMEGA_C = (OMEGA1)/(((1/A1^2) - 1)^(1/(2*N)));


% determining analog transfer function

syms s;

if rem(N,2) == 0
   % N is even 
   h(s) = s;
   for k = 1:N/2
       b = (2*sin(((2*k - 1)*pi)/(2*N)));
       h(s) = h(s) * ((OMEGA_C^2)/(s^2 + b*OMEGA_C*s + OMEGA_C^2));
   end
   h(s) = h(s) / s;
   
else
   % N is odd
   h(s) = (OMEGA_C) / (s + OMEGA_C);
   for k = 1:(N-1)/2
      b = (2*sin(((2*k - 1)*pi)/(2*N)));
      h(s) = h(s) * ((OMEGA_C^2)/(s^2 + b*OMEGA_C*s + OMEGA_C^2));
   end
end


% comverting tha transfer function in z domain using bilinear
% transformation
syms z;

g(z) = h(((2/T)*((1 - z^-1)/(1 + z^-1))));

ezplot(g,[0,pi]);

[nx, dx] = numden(simplify(collect(g)));

N = sym2poly(nx);
D = sym2poly(dx);

fvtool(N,D);
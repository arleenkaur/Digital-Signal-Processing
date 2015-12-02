%% Low-Pass Filter
clear all;
clc;
close all;

%% reading image (grayscale)
I_orig = imread('logo.jpg');
I_orig = rgb2gray(I_orig);

[M,N] = size(I_orig);

%% Image in frequency domain
F = fft2(I_orig);
F = fftshift(F); % Center FFT

F = abs(F); % Get the magnitude
F = log(double(F+1)); % Use log, for perceptual scaling, and +1 since log(0) is undefined
F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1

imshow(F,[]),title('Input image in frequency domain'); % Display the result
figure

%% adding noise to the image
I = imnoise(I_orig,'gaussian');

%% Finding D(u,v)
D = zeros(size(I));
for u = 1:M
    for v = 1:N
        D(u,v) = ((u-(M/2))^2 + (v-(N/2))^2)^(1/2);
    end
end

%% finding H(u,v)

distance = 40;
order = 1/10;

H = zeros(size(I));
for u = 1:M
    for v = 1:N
        H(u,v) = 1/(1 + (D(u,v)/distance)^2*order);
    end
end

mesh(H);
figure

%% Processing
F = fft2(I);
F = fftshift(F);
Y  = F.*H;


Y1 = ifftshift(Y);

y = ifft2(Y1);

%% Displaying results
subplot(131),imshow(I_orig),title('Original image');
subplot(132),imshow(I),title('Original Image with noise');
subplot(133),imshow(uint8(y)),title('Output image');

%% Chebyshef

I = imread('logo.jpg');
I = rgb2gray(I);

I_noise = imnoise(I,'salt & pepper');

order = 11;
p2p_ripple = 2;
cut = 0.2;

[n, d] = cheby1(order, p2p_ripple, cut);

fvtool(n,d);

I_output = filter(n, d, double(I_noise));

subplot(131),imshow(I),title('Original Image');
subplot(132),imshow(I_noise),title('Original Image with gaussian noise');
subplot(133),imshow(uint8(I_output)),title('Filtered image with chebyshef fileter');
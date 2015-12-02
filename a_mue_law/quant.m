function y = quant( x, steps, maxv )
% This function takes three inputs : 
%   i.  x     -> The input sampled sequence
%   ii. steps -> Number of levels of quantization = 2*no of bits
%   iii. maxv -> maximum output value
% The function then returns the vector y, which is the quantized
% form of vector 'x', in 'steps' levels, using a floor function.
% Any value above (or below) maxv (-maxv) is truncated to maxv (-maxv).

% The input and output are also plotted separately.

    y = zeros(size(x)); 
    delta = 2*maxv/(steps - 1);
    
    for i = 1:length(x)
        if x(i) >= maxv
            y(i) = maxv;
        elseif x(i) <= -maxv
            y(i) = -maxv;
        elseif (x(i) <= 0.1) && (x(i) > -0.1) % dead zone condition
            y(i) = 0;
        else
            % mid - riser quantizer
            y(i) = delta*(floor(x(i)/delta)+0.2);
        end
    end
    
    figure(1);
    subplot(121),stem(x),title('Input Signal');
    subplot(122),stem(y,'r'),title('Quantized Signal');
    
end


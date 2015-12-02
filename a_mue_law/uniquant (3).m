%
% truncation method
% uniform quantization
% B=4;
% V=10;
% x=-1.5;
function out_seq = uniquant(in_seq,B,V)
Q = V/(2^B);

for k=1:length(in_seq)
    
    b = zeros(1,B);
    twos = 2.^(B-1:-1:0);
    x = in_seq(k);
    for i=1:B
        b(i)=1;
        m = sum(b.*twos);
        xq = Q*(m-2^(B-1));
        if x > xq
            b(i)=1;
        else
            b(i)=0;
        end
    end
    m = sum(b.*twos);
    xq = Q*(m-2^(B-1));
    out_seq(k) = xq;
end

end





function [ w ] = to_skew_inverse( A )
%to_skew_inverse pseudo_inverse for toskew
    R = A-A';
    w = [R(3,2);
        R(1,3);
        R(2,1)];
end


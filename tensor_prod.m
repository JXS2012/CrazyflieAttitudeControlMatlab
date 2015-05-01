function [ c ] = tensor_prod( u )
%tensor_prod return tensor product between u and u
    c = [u(1)^2 u(1)*u(2) u(1)*u(3);
        u(1)*u(2) u(2)^2 u(2)*u(3);
        u(1)*u(3) u(2)*u(3) u(3)^2];


end


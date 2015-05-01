function [ ds ] = to_state( dR, dw )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

    ds = [dR(1,1);
        dR(1,2);
        dR(1,3);
        dR(2,1);
        dR(2,2);
        dR(2,3);
        dR(3,1);
        dR(3,2);
        dR(3,3);
        dw(1)
        dw(2)
        dw(3)];
end


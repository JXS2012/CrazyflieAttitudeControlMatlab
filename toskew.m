function [ skew_w ] = toskew( w )
%TOSKEW Summary of this function goes here
%   Detailed explanation goes here
    skew_w = [0 -w(3) w(2); w(3) 0 -w(1); -w(2) w(1) 0];

end


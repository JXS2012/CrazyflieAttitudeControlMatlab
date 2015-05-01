function [ p ] = varphi( E )
%VARPHI Potential function
    global constants
    p = trace(constants.P*(eye(3)-E));


end


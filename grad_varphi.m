function [ gradient ] = grad_varphi( R, M )
%grad_varphi Gradient of potential function on SO(3)
    global constants
    gradient = 2*M\to_skew_inverse(constants.P*R);

end


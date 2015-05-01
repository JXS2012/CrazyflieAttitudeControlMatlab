function [ n ] = get_non_gradient_control( E,e,a,d,ddot,M )
%get_non_gradient_control get the non gradient part in controller
    n = M*(E'*ddot-toskew(a)*E'*d)+toskew(a)*M*E'*d+toskew(E'*d)*M*e;
end


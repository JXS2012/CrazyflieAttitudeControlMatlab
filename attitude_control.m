function [ u ] = attitude_control( E, e, R, w, d, ddot, M )
%ATTITUDE_CONTROL attitude controller
% E 3X3 error in rotation
% e 3X1 error in angular velocities
% R 3X3 current rotation Matrix
% w 3X1 angular velocity
% d 3X1 desired angular velocity
% ddot 3X1 desired angular velocity
% M 3X3 inertia matrix

    global constants

    u_1 = get_non_gradient_control(E,e,w,d,ddot,M);
    u_2 = -constants.k2*e;
    u_3 = -constants.k1*grad_varphi(E, M);
    u =  u_1 + u_2 + u_3;

end


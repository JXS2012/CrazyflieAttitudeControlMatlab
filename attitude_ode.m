function ds = attitude_ode( t, s )
%ATTITUDE_ODE attitude velocity dynamics
    global constants
    
    R = [s(1) s(2) s(3);
        s(4) s(5) s(6);
        s(7) s(8) s(9)];
    
    w = s(10:12,1);
    
    p = s(13:21,1);
    
    D = [s(22) s(23) s(24);
        s(25) s(26) s(27);
        s(28) s(29) s(30)];
    
    d = s(31:33,1);
    
    dD = D*toskew(d);
    
    dd = [-s(32)*constants.alpha_d;
        s(31)*constants.alpha_d;
        0];
    
    E = D'*R;
    
    e = w - E'*d;
    
    d_control = zeros(3,1);
    dd_control = zeros(3,1);
    
    H = find_H(E,e,w,d_control,dd_control);
    
    u = attitude_control(E, e, R, w, d_control, dd_control, constants.Jhat);%+H*p;
    
    dR = R*toskew(w);
    dw = constants.J\(u - toskew(w)*constants.J*w);
    
    dp = -H'*(constants.gammabar*e+...
        constants.kp*2/(1+2*norm(to_skew_inverse(constants.P*E)))*...
        to_skew_inverse(constants.P*E));
    
    ds = [to_state(dR, dw);dp;to_state(dD,dd)];
    
end


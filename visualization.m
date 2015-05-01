function [es, ut, potential, pt, ej] = visualization( t,s )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    global constants
    
    es = zeros(size(s),12);
    ut = zeros(size(s,1),3);
    potential = zeros(size(s,1),1);
    pt = zeros(size(s,1),9);
    ej = zeros(size(s,1),3);
    filename = 'tracking.gif';
    currentFrame = 0;
    figure()
    for i = 1:size(s,1)
        currentFrame = currentFrame + 1;
        R = [s(i,1) s(i,2) s(i,3);
            s(i,4) s(i,5) s(i,6);
            s(i,7) s(i,8) s(i,9)];
        
        
        w = [s(i,10); s(i,11); s(i,12)];
        
        p = s(i,13:21)';
        
        D = [s(i,22) s(i,23) s(i,24);
            s(i,25) s(i,26) s(i,27);
            s(i,28) s(i,29) s(i,30)];
        
        d = s(i,31:33)';
        
        dd = [-s(i,32)*constants.alpha_d;
            s(i,31)*constants.alpha_d;
            0];

        E = D'*R;
        
        e = w - R'*D*d;
        
        d_control = zeros(3,1);
        dd_control = zeros(3,1);            
        H = find_H(E,e,w,d_control,dd_control);
        u = attitude_control(E, e, R, w, d_control, dd_control, constants.Jhat);% + H*p;
        
        es(i,:) = to_state(E,e)';
        ut(i,:) = u;
        pt(i,:) = s(i,13:21);
        ej(i,:) = constants.J\H*squeeze(pt(i,:))';
        
        PEinv = to_skew_inverse(constants.P*E);
        potential(i) = constants.gammabar*(constants.k1*varphi(E)+...
            (constants.k2.^2*e)'*constants.J*(constants.k2.^2*e)) + ...
            constants.kp*2/(1+2*norm(PEinv))*e'*constants.J*PEinv;

        plot_rotation(R,['+X';'+Y';'+Z'], '-r');
        hold on
        
        plot_rotation(eye(3), ['+X0';'+Y0';'+Z0'],'-b');
        hold on
        
        plot_rotation(D, ['+XD';'+YD';'+ZD'],'-g');
        axis([-2 2 -2 2 -2 2])
        
        drawnow
        
        frame = getframe;
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if currentFrame == 1;
            imwrite(imind,cm,filename,'gif','Loopcount',inf);
        else
            imwrite(imind,cm,filename,'gif','WriteMode','append');
        end
        
        clf;
    end
    
    figure()
    plot(potential)
    drawnow
    

% 
%     figure()
%     for i = 1:size(s,1)
%         E = [es(i,1) es(i,2) es(i,3);
%             es(i,4) es(i,5) es(i,6);
%             es(i,7) es(i,8) es(i,9)];
%         plot_rotation(E, ['+X';'+Y';'+Z']);
%         hold on
%         
%         plot_rotation(eye(3), ['+X0';'+Y0';'+Z0']);
%         hold on
%         axis([-2 2 -2 2 -2 2])
%         drawnow
%         
%         clf;
%     end
%     
end


clear
clc
close all
%%
%This code package implements a potential field based attitude controller
%The controller is described in D. E. Koditschek, "Application of a new
%lyapunov function to gloabl adaptive attitude tracking" in Proceedings of
%the 27th Conference on Decision and Control Austin, Texas December, 1988
global constants

%Inertia Matrix
constants.J = [2 0 0;
               0 2 0;
               0 0 3];
%Estimate Inertia Matrix
constants.Jhat = [1 0 0;
               0 1 0;
               0 0 1];
%Controller Gains
constants.k2 = 1*[1 0 0;
                0 1 0;
                0 0 1];
constants.k1 = 10;
            
constants.gammabar = 10;
constants.kp = 1;

%Potential Field Matrix
constants.P = [1 0 0;
                0 2 0;
                0 0 1];

%Create Rotation Matrix based on rotation angle and axis of rotation
[R_0] = create_rotation_matrix(0, [1, 0, 0]);
w_0 = zeros(3,1);
p_0 = zeros(9,1);

%Desired Rotation Matrix and Desired Angular Velocity. Both can be time
%varing.
[D_0] = create_rotation_matrix(pi/4, [1, 0, 0]);
d_0 = [1,0,0];
constants.alpha_d = pi/4;

%State space containing Rotation Matrix, Angular Velocity, Desired Rotation
%Matrix, and Desired Angular Velocity
s_0 = [to_state(R_0, w_0);p_0;to_state(D_0,d_0)];

%%
%Simulator using ODE45
T = 10;
t = linspace(0,T,T*20);
[t, s] = ode45(@attitude_ode, t, s_0);

%%
%Visualize the controller
[es, ut, potential, pt,ej] = visualization(t,s);

%%
%Control Effort
figure()
plot(t,ut)

%%
%Error between True Rotation Matrix and Desired Rotation Matrix
%It converges to zero.
figure()
plot(t,ej)
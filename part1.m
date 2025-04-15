%{
Natalia Hopper
Jerom Jothiprakasam
Math 245 -- MATLAB Project 3
(Part 1)

Revision History
Date            Changes             Programmer
-------------------------------------------------------
04/15/25        original            Jerom Jothiprakasam
04/15/25        part (a)            Jerom Jothiprakasam
04/15/25        part (b)            Jerom Jothiprakasam
04/15/25        part (c)            Jerom Jothiprakasam
%}

clc;
clear;

%% General settings

tspan = [0 100];                    % Time range
omega_vals = [0.9, 1.1, 1];         % For undamped: omega < 1, omega > 1, resonance
omega_damped = 1;                   % Fixed for damped cases
c_vals = [0, 0.5, 1, 1.5];          % 0 = undamped, rest are under, critical, over
init_default = [0; 0];              % x(0) = 0, x'(0) = 0

%% Function for system of 1st order ODEs
f_t = @(t, x, c, omega) [x(2); -2*c*x(2) - x(1) + cos(omega*t)];

%% Part (a)
for i = 1:2
    omega = omega_vals(i);
    [t, x] = ode45(@(t,x) f_t(t, x, 0, omega), tspan, init_default);
    figure;
    plot(t, x(:,1), 'LineWidth', 1.5);
    title(['Undamped (c = 0), Beats with \omega = ' num2str(omega)]);
    xlabel('Time t'); ylabel('Displacement x(t)');
    grid on;
end

% Resonance case
[t, x] = ode45(@(t,x) f_t(t, x, 0, omega_vals(3)), tspan, init_default);
figure;
plot(t, x(:,1), 'r', 'LineWidth', 1.5);
title('Undamped (c = 0), Resonance with \omega = 1');
xlabel('Time t'); ylabel('Displacement x(t)');
grid on;

%% Part (b)
for i = 2:4
    c = c_vals(i);
    [t, x] = ode45(@(t,x) f_t(t, x, c, omega_damped), tspan, init_default);
    figure;
    plot(t, x(:,1), 'LineWidth', 1.5);
    title(['Damped, c = ' num2str(c) ', \omega = ' num2str(omega_damped)]);
    xlabel('Time t'); ylabel('Displacement x(t)');
    grid on;
end

%% Part (c)
initial_conditions1 = [1; -1];
initial_conditions2 = [-1; 2];
c = 0.5; % Underdamped
[t1, x1] = ode45(@(t,x) f_t(t, x, c, omega_damped), tspan, initial_conditions1);
[t2, x2] = ode45(@(t,x) f_t(t, x, c, omega_damped), tspan, initial_conditions2);

figure;
plot(t1, x1(:,1), 'b', 'LineWidth', 1.5); hold on;
plot(t2, x2(:,1), 'r--', 'LineWidth', 1.5);
title(['Effect of Initial Conditions (Underdamped, c = ' num2str(c) ')']);
xlabel('Time t'); ylabel('Displacement x(t)');
legend('IC: [1; -1]', 'IC: [-1; 2]');
grid on;
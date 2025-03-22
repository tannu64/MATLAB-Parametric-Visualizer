clc;
close all;
clear;

% Define your name
name = 'Feel Xvix';

% Define a row vector named x with user input
validInput = false;
while ~validInput
    stepSize = input('Enter a step size between 0.5 and 3: ');
    if stepSize >= 0.5 && stepSize <= 3
        validInput = true;
    else
        disp('Error: Step size must be between 0.5 and 3.');
    end
end
x = -6:stepSize:6;

% Define a second row vector y with ten evenly distributed values
y = linspace(-6, 6, 10);

% Create a meshgrid from x and y
[X, Y] = meshgrid(x, y);

% Compute Z as the area hyperbolic sine of the product of X and Y
Z = asinh(X .* Y);

% Create a vector for the parameter t with 75 equidistant values between 0 and 2?
t = linspace(0, 2*pi, 75);

% Compute the vectors xt1 and yt1 of an ellipse in the xy-plane with a = 5 and b = 3
a = 5;
b = 3;
xt1 = a * cos(t);
yt1 = b * sin(t);

% Compute the vectors xt2 and yt2 of a spiral
xt2 = (log(2 * t + 1) + 1) .* cos(t);
yt2 = (log(2 * t + 1) + 1) .* sin(t);

% Compute zt1 and zt2 with xti = asinh(xti .* yti) for i = 1, 2
zt1 = asinh(xt1 .* yt1);
zt2 = asinh(xt2 .* yt2);

% Store the variables xt1, yt1, and zt1 in a data structure named Curves
Curves(1).xt = xt1;
Curves(1).yt = yt1;
Curves(1).zt = zt1;

% Store the variables for the second curve
Curves(2).xt = xt2;
Curves(2).yt = yt2;
Curves(2).zt = zt2;

% Plot the 3D surface
figure;
subplot(2,1,1);
mesh(X, Y, Z);
title('Areasinus hyperbolicus');
xlabel('x');
ylabel('y');
zlabel('z');
hold on;

% Plot the curves on the surface
plot3(Curves(1).xt, Curves(1).yt, Curves(1).zt, 'r', 'DisplayName', 'Ellipse');
plot3(Curves(2).xt, Curves(2).yt, Curves(2).zt, 'g', 'DisplayName', 'Spiral');
legend('show');

% Plot the 2D curves
subplot(2,1,2);
plot(t, Curves(1).zt, 'r', 'DisplayName', 'Ellipse');
hold on;
plot(t, Curves(2).zt, 'g', 'DisplayName', 'Spiral');
title('Schnittkurven');
xlabel('t in rad');
ylabel('z');
legend('show');

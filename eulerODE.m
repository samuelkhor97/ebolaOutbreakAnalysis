function [tOut, yOut] = eulerODE(f,t0, tfinal, y0, h)
%Input: f=function handler,t0=starting time,tfinal=ending time,y0=initial
%condition,h=step size
%Output: tOut=time,yOut=correponding solution for each tOut
%Description: solve 1st-order Ordinary Differential Equation

tOut = zeros([1 tfinal-t0]);
yOut = zeros([1 tfinal-t0]);
yOut(1) = y0;
yTemp = y0;

counter = 2;
for time = (t0+h+1):h:tfinal
    tOut(counter) = time;
    yOut(counter) = yTemp + h*f(yTemp);  % applying Euler's method
    yTemp = yOut(counter);
    counter = counter + 1;
end
end

% Name: Khor Peak Siew
% Last modified: 21/2/2017
% ========================================================================

kc = 0.09:0.01:0.3;
r2_values = zeros([1 length(kc)]);  % initializing the r2 values for Euler
ode_r2_values = zeros([1 length(kc)]);  % initializing the r2 values for ODE45

y = weeks_guinea_cases;  % assigning the weekly cumulative cases of guinea to y
y0 = weeks_guinea_cases(1);  % assigning first week cases number to y0

st = @(y) sum((y-mean(y)).^2);
sr = @(y,yfit) sum((y-yfit).^2);
r2 = @(y,yfit) (st(y) - sr(y,yfit)) / st(y);  %  Calculate r2

counter = 1;
for i = kc
    dCdt = @(c) i*c;  % create function handle for the ODE
    
    [~, yfit] = eulerODE(dCdt,0,length(y),y0,1);  % finding the fitted y values using Euler method
    [~, ode_y] = ode45(@(t,c) i*c,1:length(y),y0);  % finding the fitted y values using built-in ODE45
    
    r2_values(counter) = r2(y,yfit);  % calculate r2 values for both methods
    ode_r2_values(counter) = r2(y,ode_y');
    
    counter = counter + 1;
end

[max_r2, ind] = max(r2_values);  % finding the best_kc value by finding the max. r2 values closest to 1
best_kc = kc(ind);
dCdt = @(c) best_kc*c;
[t, predicted_weekly_cumulative] = eulerODE(dCdt,0,50,y0,1);

[max_ode_r2, ode_ind] = max(ode_r2_values);  % finding the best_ode_kc value by finding the max. ode_r2 values closest to 1
best_ode_kc = kc(ode_ind);
[ode_t, ode_predicted_weekly_cumulative] = ode45(@(t,c) best_ode_kc*c,1:50,y0);

% Solution for Guinea/ Liberia/ Sierra Leonne based on the last digit of
% your student ID.
figure
plot(weeks,weeks_guinea_cases,'k.')
hold on
plot(t,predicted_weekly_cumulative,'b-')  % plotting the graph for the raw datas and two predicted sets of values
title('Weekly Cumulative Cases in Guinea')
xlabel('Number of Weeks')
ylabel('Incident Count')
plot(ode_t,ode_predicted_weekly_cumulative,'r-')
legend('Original Data','Euler Method','ODE45 Method')

fprintf('Guinea\n')
fprintf('EULER: r^2 value = %.4f, Kc = %.4f\n',max_r2,best_kc)
fprintf('ODE45: r^2 value = %.4f, Kc = %.4f\n',max_ode_r2,best_ode_kc)

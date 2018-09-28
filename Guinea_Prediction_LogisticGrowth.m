% Name: Khor Peak Siew
% Last modified: 22/12/2017
% ========================================================================


% Values for r to be taken from Q2d.
r = 0.09:0.001:0.3;
% Values for K to be taken from last reported value
K = file.data(1,1):100:file.data(1,1)+1000;

% Calculate r2
st = @(y) sum((y-mean(y)).^2);
sr = @(y,yfit) sum((y-yfit).^2);
r2 = @(y,yfit) (st(y) - sr(y,yfit)) / st(y);

% initialize the vector array r2_attempts to contain the coefficient of r^2 values for determining best K & r values
r2_attempts = zeros([length(K) length(r)]);

for i = 1:1:length(K)
    for j = 1:1:length(r)
        % finding the fitted y values using built-in ODE45
        [~, ode_y1] = ode45(@(t,c) r(j)*c*(1-c/K(i)),1:length(y),y0);
        r2_attempts(i,j) = r2(y,ode_y1');
    end
end

% finding the max. r^2 values
max_r2_attempt = max(max(r2_attempts));
[ind1, ind2] = find(r2_attempts == max_r2_attempt);
% determine K & r values with the max. r^2 values
K_selected = K(ind1);
r_selected = r(ind2);

% finding the predicted weekly cumulative cases for 150 weeks
[ode_t1, ode_predicted_150_weekly_cumulative] = ode45(@(t,c) r_selected*c*(1-c/K_selected),1:150,y0);
% rounding the case numbers to integers
ode_predicted_150_weekly_cumulative = round(ode_predicted_150_weekly_cumulative,0);

% determine the total number of cases at week 150 with bisection,secant and fzero()
dCdt = @(c) r_selected.*c.*(1-c./K_selected);
bisection_zero = find_root_bisection(dCdt,3500, 3900,10);
secant_zero = find_root_secant_method(dCdt,3500,3700,1);
fzero_zero = fzero(dCdt,3000);

% determine the ending week of the epidermic for 3 different methods
ending_num_bisection = min(ode_t1(ode_predicted_150_weekly_cumulative > bisection_zero));
ending_num_secant = min(ode_t1(ode_predicted_150_weekly_cumulative > secant_zero));
ending_num_fzero = min(ode_t1(ode_predicted_150_weekly_cumulative >= fzero_zero));

% plot the actual data,logistic data and ending week of epidermic in a new figure
figure
plot(weeks,weeks_guinea_cases,'k.')
hold on
title('Weekly Cumulative Cases in Guinea')
xlabel('Number of Weeks')
ylabel('Incident Count')
plot(ode_t1,ode_predicted_150_weekly_cumulative,'b-')
plot(ending_num_fzero, fzero_zero,'ro')
legend('Actual Data','Logistic Model','End of Epidermic','Location','Northwest')

fprintf('Guinea\n')
fprintf('r^2 value = %.4f\n',max_r2_attempt)
fprintf('Recommended intrinsic growth rate, r = %.4f and final epidemic size, K = %.0f.\n',r_selected,K_selected)
fprintf('The Epidermic in Guinea is estimated to end at Week: \n')
fprintf('\n')
fprintf('Using fzero(): Week %.0f, with a Total Number of %.0f Cases.\n',ending_num_fzero,round(fzero_zero,0))
fprintf('Using bisection method: Week %.0f, with a Total Number of %.0f Cases.\n',ending_num_bisection,round(bisection_zero,0))
fprintf('Using secant method: Week %.0f, with a Total Number of %.0f Cases.\n',ending_num_secant,secant_zero)




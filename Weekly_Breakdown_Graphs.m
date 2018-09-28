% ========================================================================
% Q2c
% ------------------------------------------------------------------------
% Name: Khor Peak Siew
% Last modified: 17/12/2017

num_days = days(1,end);
weeks = 1:ceil(num_days/7);  % initializing number of n-th week

weeks_guinea_cases = [];  % initializing weekly cumulative cases for the three countries
weeks_liberia_cases = [];
weeks_sierra_cases = [];

weeks_guinea_deaths = [];   % initializing weekly cumulative deaths for the three countries
weeks_liberia_deaths = [];
weeks_sierra_deaths = [];

for j = row1:-1:2
    nth_week = floor((datenum(file.textdata(j,1),'dd/mm/yyyy') - first_day) / 7) + 1;  % determine the n-th week for cases/deaths
    
    weeks_guinea_cases(1,nth_week) = file.data(j-1,1);  % assigning cumulative cases in the n-th week
    weeks_liberia_cases(1,nth_week) = file.data(j-1,2);
    weeks_sierra_cases(1,nth_week) = file.data(j-1,3);
    
    weeks_guinea_deaths(1,nth_week) = file.data(j-1,9);  % assigning cumulative deaths in the n-th week
    weeks_liberia_deaths(1,nth_week) = file.data(j-1,10);
    weeks_sierra_deaths(1,nth_week) = file.data(j-1,11);
end

figure
subplot(2,3,1)  % plotting the bar graph for each country for their respective cumulative cases
bar(weeks,weeks_guinea_cases)
title('Weekly cumulative cases for Guinea')
xlabel('Number of weeks')
ylabel('Cumulative cases')
hold on

subplot(2,3,2)
bar(weeks,weeks_liberia_cases)
title('Weekly cumulative cases for Liberia')
xlabel('Number of weeks')
ylabel('Cumulative cases')


subplot(2,3,3)
bar(weeks,weeks_sierra_cases)
title('Weekly cumulative cases for Sierra Leone')
xlabel('Number of weeks')
ylabel('Cumulative cases')

subplot(2,3,4)  % plotting the bar graph for each country for their respective cumulative deaths
bar(weeks,weeks_guinea_deaths)
title('Weekly cumulative deaths for Guinea')
xlabel('Number of weeks')
ylabel('Cumulative deaths')

subplot(2,3,5)
bar(weeks,weeks_liberia_deaths)
title('Weekly cumulative deaths for Liberia')
xlabel('Number of weeks')
ylabel('Cumulative deaths')

subplot(2,3,6)
bar(weeks,weeks_sierra_deaths)
title('Weekly cumulative deaths for Sierra Leone')
xlabel('Number of weeks')
ylabel('Cumulative deaths')

hold off
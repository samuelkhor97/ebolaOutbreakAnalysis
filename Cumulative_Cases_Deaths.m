% Name: Khor Peak Siew
% Last modified: 12/12/2017
% ========================================================================

% Calculate no. of day base of the date given
% [Suggestion] days = datenum(date,'dd/mm/yyyy') - datenum(date(end),'dd/mm/yyyy')+1;

file = importdata('ebola_timeseries.csv');  % import datas from the file
[row,c] = size(file.data);
[row1,c1] = size(file.textdata);

for i = 1:1:16  % replacing those NaN values with the previous numbers before them
    if isnan(file.data(row,i))  %  replacing the NaN values at last row with '0'
        file.data(row,i) = 0;
    end
    
    prev_entry = file.data(row,i);
    for j = row:-1:1
        if isnan(file.data(j,i))
            file.data(j,i) = prev_entry;
        end
        prev_entry = file.data(j,i);
    end
end

days = zeros([1 row1-1]);  % computing the number of days and put them in an array
first_day = datenum(file.textdata(row1,1),'dd/mm/yyyy');
for date = row1:-1:2
    days(1,row1-date+1) = datenum(file.textdata(date,1),'dd/mm/yyyy') - first_day + 1;
end

cumulative_cases = zeros([1 row]);
for day = row:-1:1  % calculate the cumulative cases for each day
    cumulative_cases(1,row-day+1) = sum(file.data(day,1:8), 'omitnan');
end

cumulative_deaths = zeros([1 row]);
for day = row:-1:1  % calculate the cumulative deaths for each day
    cumulative_deaths(1,row-day+1) = sum(file.data(day,9:16), 'omitnan');
end

figure
plot(days,cumulative_cases,'b-',days,cumulative_deaths,'r-',1,0,'gs','Markersize',10)
text(1,1e3, sprintf('Day 1: %s',datestr(first_day,'dd/mm/yy')),'FontSize',10)
title('Cumulative cases/deaths against Days')
xlabel('Number of days')
ylabel('Cumulative cases/deaths')
legend('Cumulative cases','Cumulative deaths')

fprintf('Most recent total cumulative cases are %.0f cases.\n',cumulative_cases(1,end))
fprintf('Most recent total cumulative deaths are %.0f deaths.\n',cumulative_deaths(1,end))
fprintf('The last reported date is %s.\n',datestr(datenum(file.textdata(2,1),'dd/mm/yyyy'),'dd/mm/yy'))
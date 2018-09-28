% Name: Khor Peak Siew
% Last modified: 17/12/2017
% ========================================================================

countries_name = {'Guinea','Liberia','Sierra Leone','Nigeria','Senegal','United States','Spain','Mali'};
for country_number  = 1:length(countries_name)  % fprintf all the countries available
    fprintf('%.0f - %s\n',country_number,countries_name{country_number})
end

days_from_zero = [0 days];
while 1  % continue prompting user for country's name if given invalid input
    country = input('Select a country: ');
    if country < 1 || country > 8  % check if the input is valid
        continue
    end
    
    [cases, deaths] = deal(country, country+8);  % find the indices of cases/deaths of given country
    country = countries_name{country};  % assigning the country variable to its string name
    
    cmlt_cases_country = zeros([1 row]);
    for day = row:-1:1  % calculate the cumulative cases of the country for each day
        cmlt_cases_country(1,row-day+1) = file.data(day,cases);
    end
    
    cmlt_deaths_country = zeros([1 row]);
    for day = row:-1:1  % calculate the cumulative deaths of the country for each day
        cmlt_deaths_country(1,row-day+1) = file.data(day,deaths);
    end
    
    cmlt_cases_country_from_zero = [0 cmlt_cases_country];
    cmlt_deaths_country_from_zero = [0 cmlt_deaths_country];
    
    figure
    plot(days_from_zero,cmlt_cases_country_from_zero,'b-',days_from_zero,cmlt_deaths_country_from_zero,'r-')  % plot the cumulative cases/deaths against days
    title(sprintf('%s''s cumulative cases/deaths',country))
    xlabel('Number of days')
    ylabel('Cumulative cases/deaths')
    legend('Cumulative cases','Cumulative deaths','Location','northwest')
    xlim([1 days(end)])
    
    decision = input('Do you want to view datas of other countries?(''y'' for yes,else Quit)','s');  % prompt if user wants to view datas of otehr countries
    if decision == 'y'
        continue
    else
        break
    end
end
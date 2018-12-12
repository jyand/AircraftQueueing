%% Aircraft Database
% This generates the database of information for all scheduled aircrafts
% on a given day. The number of customers in a day is random from a
% range, clustered around the max of that range close to Thanksgiving
% and Christmas. The objective is to minimize the amount of time each
% passenger spends waiting and maximize the amount of passengers in an
% AC. Suppose a flight is scheduled every 15 minutes.

function AC = acDatabase(month, day, year)
    AC_max = 100:50:400;
    
    a = randi([1000 10000]);
    b = randi([10000 100000]);
    f = @(x) abs(sin(4*x)./x);
    % number of total scheduled flights
    n = randi([100 256]);
    % week of Thanksgiving
    if month == 11
        % determine the date of thanksgivng that year
        incr =  abs(year-2019);
        for i = 1:incr
            if mod(year, 4) == 0
                incr = incr + 2;
            else
                incr = incr + 1;
            end
        end
        tday = 7 - mod(7, incr) + 21;
        if abs(day-tday) < 7
            N = f(day-tday)*randi([a b]);
        else
            N = randi([a b]);
        end
    end
    % week of Christmas
    if month == 12 && abs(25-day) < 6
        N = f(day-tday)*randi([a b]);
    else
        N = randi([a b]);  
    end
    AC = [];
    for i = 1:n
        for j = 1:6
            switch j
                case 1
                    AC(i, j) = i;
                case 2 % AC type (capacity)
                    seed = randi([1 7]);
                    AC(i, j) = AC_max(seed);
                case 3 % number of passengers
                if seed == 1 || seed == 2  
                    AC(i,j) = randi([0 AC_max(seed)]);
                else
                    AC(i,j) = randi([AC_max(seed-2) AC_max(seed)]);
                end
                case 4 % numbering of passengers leaving the plane at the next stop
                    AC(i,j) = randi([0 AC(i, j-1)]);
                case 5 % numbering of passengers boarding the plane at the next stop
                    AC(i, j) = randi([0 AC(i, j-3)-AC(i, j-1)]);
                otherwise % scheduled time for pushback, unformatted in minutes
                    AC(i, j) = (i-1)*15;
            end
        end
    end	
end

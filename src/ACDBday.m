%% Aircraft Database
% This generates the database of information for all scheduled aircrafts
% on a given day. The number of customers in a day is random from a
% range, clustered around the max of that range close to Thanksgiving
% and Christmas. The objective is to minimize the amount of time each
% passenger spends waiting and maximize the amount of passengers in an
% AC. Suppose a flight is scheduled every 15 minutes.

function AC = ACDBday(month, day, year)
    actype = 100:50:400;
    % number of discrete time intervals, each is 15 minutes
    N = 96;
    f = @(x) abs(3*sin(3*x)./x) + pi/2;
    % determine the date of thanksgivng that year
    incr =  abs(year-2019);
    for i = 1:incr
        if mod(year, 4) == 0
            incr = incr + 2;
        else
            incr = incr + 1;
        end
    end
    % week of Thanksgiving
    if month == 11
        hday = 7 - mod(7, incr) + 21;
    % week of Christmas
    elseif month == 12 && abs(25-day) < 6
        hday = 25;
    else
        hday = 0;
    end
 
    for i = 1:N
        cap = randi([1 7]);
        n = randi([actype(cap)-50 actype(cap)+50]);
        for j = 1:5
            switch j
                case 1
                    AC(i, j) = actype(cap);
                case 2 % number of passengers
                    if hday
                        AC(i, j) = round(f(abs(day-hday)+1)*n/(exp(1)/2));
                    else
                        AC(i, j) = n;
                    end
                case 3 % number of passengers leaving at the next stop
                    AC(i,j) = randi([0 AC(i, j-1)]);
                case 4 % number of passengers boarding at the next stop
                    AC(i, j) = randi([0 AC(i, j-2) - AC(i, j-1)]);
                otherwise % timesetp, t
                    AC(i, j) = i;
            end
        end
    end	
end

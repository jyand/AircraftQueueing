%% The Aircraft Queueing Problem
% Author: John DeSalvo
%
% For each scheduled flight, the following information is available:
% ~ the scheduled time for departure
% ~ the actual time of departure
% ~ the number of passengers on board
% ~ the number of passengers who board on at the next stop
% ~ the number of passengers who board off at the next stop
% ~ the total time duration of the next stop
% ~ the scheduled time of arrival at the next stop
% In this case, there are 7 different types of aircrafts with maximum
% passenger capacities that vary from 100 to 400 in increments of 50.
% The objective of this mathematical model, qualitatively, is to "account
% for the satisfaction of both the passengers and the airline".

% AC = ACDBday(4, 21, 2019)

nErr = AC(:, 1) - AC(:, 2);

% Case where no flight leaves until it is at full capacity:
% ~ if over capacity, the extra people will wait for a subsequent plane
% ~ if under capacity, the plane waits in queue and the seats are filled at
% the next time interval
q = 0;
ncum = max([0 nErr(1)]);
tErr(1) = 15*heaviside(nErr(1));
err = heaviside(nErr(1))*nErr(1);
for i = 2:length(AC)
    if heaviside(nErr(i))
        if nErr(i) < abs(nErr(i-1))
            nErr(i) = nErr(i) - nErr(i-1);
            err = err + AC(i, 2) + nErr(i);
            q = q + 1;
        else
            nErr(i) = nErr(i) + nErr(i-1);
            ncum = ncum + nErr(i);
            err = err + nErr(i);
            q = q - 1;
        end
    else
        if ncum > abs(nErr(i))
            ncum = ncum - (ncum - abs(nErr(i)));
            err = err + ncum;
        else
            q = q + 1;
            err = err + AC(i, 2);
        end
    end
    tsched(i) = i*15;
    tactual(i) = tsched(i) + q*15;
    tErr(i) = tactual(i) - tsched(i); 
    fprintf('%4d | %4d | %4d  | %6d \n', tsched(i), tactual(i), tErr(i), 15*err);
end

% Case where every flight leaves as scheduled:
%ncum = 0;
%capErr = 0;
%err = 0;
%for i = 1:length(AC)
 %   if heaviside(nErr(i))
  %      ncum = ncum + nErr(i);
   % else
    %    capErr = capErr + nErr(i);
     %   ncum = ncum - 
    %end
    %err = err + ncum;

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

AC = ACDBday(4, 20, 2019)

nErr = AC(:, 1) - AC(:, 2);
ncum = 0;
manhours = 0;
tdelay = 0;

% first we run the simulation for a day to show what happens when people 
% are kept waiting
% if over capacity, the extra people will wait for a subsequent plane
% if under capacity, the plane waits in queue and the seats are filled at
% the next time interval
for i = 1:length(AC)-1
    if heaviside(nErr)
        
    fprintf('%4d | %4d | %4d \n', tsched(i), tactual(i), tactual(i)/tsched(i));
end

%then we run it again to show what happens when every flight runs on
%schedule
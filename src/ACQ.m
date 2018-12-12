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

% non-formatted time of day, i.e. 0 is 12am 1439 is 11:50pm
clk = 0:1:1439;
    
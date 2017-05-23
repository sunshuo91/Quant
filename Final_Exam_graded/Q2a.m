% Shuo Sun
% Q2a Long Call Ladder Strategy (Plotting)
%STU: 10/10 points. 
clc; clear;

k_itm = 30;
k_atm = 35;
k_otm = 40;

sT = [20:50]'; %USD
payoff = get_ladder_payoff(k_itm, k_atm, k_otm, sT);


disp('Problem 3:************************');
disp(' ');
disp('See plot window');
plot(sT,payoff);
title('Ladder Payoff vs. Stock Price');
xlabel('Stock Price (USD)');
ylabel('Ladder Payoff (USD)');
disp(' ');disp(' ');

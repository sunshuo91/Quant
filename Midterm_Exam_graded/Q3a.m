clc;
clear;
%STU: 10/10 points. 

stock_price = [15:45]';
strike_price = 28;

payoff = get_strip_payoff(stock_price, strike_price);

plot(stock_price,payoff);
title('Strip Payoff vs. Stock Price');
xlabel('Stock Price (USD)');
ylabel('Strip Payoff (USD)');
disp(' ');disp(' ');



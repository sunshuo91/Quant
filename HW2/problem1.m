%
% Problem 1: Valuing forward contracts
%

time_to_maturity = 0.5;
stock_price = 25;
delivery_price = 24;
risk_free = 0.1;

forward_price = forward(stock_price, delivery_price, risk_free, time_to_maturity);

disp('Problem 1: *********************');
disp('');
disp('The value of the forward contract is');
disp(forward_price);
disp('');disp('');

function result = forward(s, K, r, t)
    result = s - K * exp(-r * t);
end
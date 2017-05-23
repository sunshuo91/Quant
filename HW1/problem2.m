%
% Problem 2: Put-call Parity
%

s = 85; % stock price
K = 90; % strick price
r = 0.05; % risk-free rate
c = 10; % call option price
p = 15; % put option price
t = 5; % time to maturity

yield = -log((c + K * exp(-r * t) - p) / s) / t;

disp('Problem 2: *********************');
disp('');
disp('The continuous implied dividend yield of the stock is');
disp(yield);
disp('');disp('');

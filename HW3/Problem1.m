%
% Problem 1: Put Options
%

clc; clear;

s0 = 42;
K = 40;
r = 0.1;
vol = 0.2;
T = 0.5;

power = 1:6;
N = 10.^power;

Put_Price = zeros(length(N), 1);
Put_SEM = zeros(length(N), 1);

for i = 1:length(N)
    St = Stock_Price_Random(s0, r, vol, T, N(i));
    Put_Payoff = Get_Put_Payoff(St, K) * exp(-r * T);
    Put_Price(i) = mean(Put_Payoff);
    Put_SEM(i) = std(Put_Payoff)/sqrt(N(i));
end



format long g;
disp('Problem 1: *********************');
disp('');
fprintf('%12s %12s %12s \n', 'Nr of Paths', 'price','SEM');
fprintf('%12d %12g %12g \n', [N; Put_Price'; Put_SEM']);
disp('');disp('');
    
function Payoff = Get_Put_Payoff(St, K)
   Payoff = max(K - St, 0);
end    


function Stock_Price = Stock_Price_Random(s0, r, vol, T, N)
   Stock_Price = s0 * exp((r-vol^2/2) * T + vol*sqrt(T)*randn(N,1));
end

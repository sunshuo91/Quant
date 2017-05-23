clc;
clear;
%STU: 15/15 points. 

s0 = 40,
sigma = 0.2;
k1 = 42;
k2 = 45
r = 0.1;
T = 0.5;

power = 1:6;
N = 10.^power;

price = zeros(length(N),1);
SEM = zeros(length(N),1);

for i = 1:length(N)

    sT = s0*exp((r-sigma*sigma/2)*T + sigma*sqrt(T)*randn(N(i),1));
    gap_payoff = get_gap_payoff(sT, k1, k2);
    discounted_payoff = gap_payoff * exp(-r*T);
    
    price(i) = mean(discounted_payoff);
    SEM(i) = std(discounted_payoff)/sqrt(N(i));
    
end


format bank;
disp('      Nr of Paths       price         SEM');
disp([N', price, SEM]);

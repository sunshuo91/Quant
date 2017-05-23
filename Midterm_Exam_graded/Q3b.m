clc;
clear;
%STU: 10/10 points. 

s0 = 30,
sigma = 0.2;
k = 28;
r = 0.1;
T = 0.5;

power = 1:6;
N = 10.^power;

price = zeros(length(N),1);
SEM = zeros(length(N),1);

for i = 1:length(N)

    sT = s0*exp((r-sigma*sigma/2)*T + sigma*sqrt(T)*randn(N(i),1));
    strip_payoff = get_strip_payoff(sT, k);
    discounted_payoff = strip_payoff * exp(-r*T);
    
    price(i) = mean(discounted_payoff);
    SEM(i) = std(discounted_payoff)/sqrt(N(i));
    
end


format bank;
disp('      Nr of Paths       price         SEM');
disp([N', price, SEM]);

% Shuo Sun
% Q2a Long Call Ladder Strategy (Pricing)
%STU: 10/10 points. 
clc; clear;

% parameters 
k_itm = 30;
k_atm = 35;
k_otm = 40; % strike price

s0 = 35;  % stock price at time zero
r = 0.1;  % risk free interest rate, per annum
vol = 0.2; % volatility
T = 0.5;  % maturity in years

drift = (r-vol*vol/2)*T;
diffusion = vol*sqrt(T);

power = 1:6;
N = 10.^power;

price = zeros(length(N),1);
priceSEM = zeros( length(N),1);

% show convergency
for i = 1 : length(N)
    
    currentN = N(i);
    sT = s0*exp( drift + diffusion*randn(currentN,1) );      
    ladder_payoff = get_ladder_payoff(k_itm, k_atm, k_otm, sT);
    discounted_payoff = ladder_payoff * exp(-r*T);
    
    price(i) = mean(discounted_payoff);
    priceSEM(i) = std(discounted_payoff)/ sqrt( currentN ); 
    
end

format bank;
disp('      Nr of Paths       price         SEM');
disp([N', price, priceSEM]);






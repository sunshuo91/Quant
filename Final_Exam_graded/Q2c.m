% Shuo Sun
% Q2a Long Call Ladder Strategy (VaR)
%STU: 14/15 points. 
clear;
clc;
format bank;

%portfolio 
holding_ladder = 10;  % options to buy "holding_ladder" shares of stocks
holding_stock = 20;  % shares of stocks

% VaR parameters
VaR_confidence = 0.99;
trading_days_per_year = 250;
horizon_days = 20;
%since our mu and volatility are annualized, we want our horizon 
%time in years
horizon_years = horizon_days/trading_days_per_year; % year

% Underlying Asset parameters
s0 = 35;
vol = 0.2;
mu = 0.30;

%option parameters
%STU: expiry should be 0.5. 
%-1 point. 
expiry = 1;
k_itm = 30;
k_atm = 35;
k_otm = 40;

%market parameter
r = 0.1;

% computation parameters
N_path_VaR = 10000;
N_path_option = 1000;


% stock price at N
sN = s0*exp( (mu-vol*vol/2)*horizon_years + vol*sqrt(horizon_years)*randn(N_path_VaR,1) );

% European call price at N
ladder_price_N = zeros(N_path_VaR,1);
for k = 1:N_path_VaR
    ladder_price_N(k) = get_ladder_price_mc( ...
        sN(k), k_itm, k_atm, k_otm, r, vol, expiry - horizon_years, N_path_option);
end

% portfolio values (puts + stock)
portfolioValue = holding_ladder * ladder_price_N + holding_stock * sN;
portfolioValue = sort(portfolioValue);

portfolioValue_average = mean(portfolioValue);
VaR_pos = floor( length(portfolioValue) * (1-VaR_confidence) );

VaR = portfolioValue_average - portfolioValue( VaR_pos );

disp('the average of the portfolio in 20 days');
disp(portfolioValue_average);
disp('  ');
disp('20-day 99% VaR');
disp(VaR);




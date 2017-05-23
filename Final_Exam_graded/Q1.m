%Shuo Sun
%Q1 Chooser Cliquet Option
%STU: exam total: 99/100 points. 
%STU: this question: 30/30 points. 
clc; clear;

% parameters
u0 = 40;
v0 = 42;
r = 0.1;
u_vol = 0.2;
v_vol = 0.5;

rho = 0.5;

T = 2;
t = 1; %delta t

power = 1:6;
N = 10.^power;

price = zeros(length(N),1);
price_SEM = zeros( length(N),1);

num_names = 2;

u_drift = (r-u_vol*u_vol/2)*t;
u_diffusion = u_vol*sqrt(t);

v_drift = (r-v_vol*v_vol/2)*t;
v_diffusion = v_vol*sqrt(t);

corr_matrix = [1, rho; 
               rho, 1];           
           


% show convergency
for i = 1 : length(N)
    
    current_N = N(i);
    
    correlated_randoms = (chol(corr_matrix,'lower')*randn(num_names,current_N))';
    correlated_randoms_2 = (chol(corr_matrix,'lower')*randn(num_names,current_N))';
    %u = normcdf(correlated_randoms');
    
    u1 = u0 * exp(u_drift + u_diffusion .* correlated_randoms(:,1));
    u2 = u1 .* exp(u_drift + u_diffusion .* correlated_randoms_2(:,1));
    
    v1 = v0 * exp(v_drift + v_diffusion .* correlated_randoms(:,2));
    v2 = v1 .* exp(v_drift + v_diffusion .* correlated_randoms_2(:,2));
    
    year_1_payoff = max(max(u1-u0, 0), max(v1-v0, 0));
    year_2_payoff = max(max(u2-u1, 0), max(v2-v1, 0));
    
    discounted_payoff = year_1_payoff * exp(-r*t) + year_2_payoff * exp(-r*T);
    
    %Store the results of this Monte Carlo simulation (with N = current_N)
    %to display when all MC simulations are complete. 
    price(i) = mean(discounted_payoff);
    price_SEM(i) = std(discounted_payoff)/ sqrt( current_N ); 
    
end

format bank;
disp('      Nr of Paths       price         SEM');
disp([N', price, price_SEM]);






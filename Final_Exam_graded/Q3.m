% Shuo Sun
% Q3 Deadline default basket swaps
%STU: 35/35 points. 
clc; clear;

% Parameters
N = 1e6; 
num_names = 3;
notional = 1;
T = 3;
t1 = 0.5; %default 1 deadline
t2 = 1; %default 2 deadline
recovery_rate = 0.5;
hazard_rate = 0.04;
interest_rate = 0.1;

c_12 = 0.2;
c_13 = 0.3;
c_23 = 0.5; % Gaussian copula correlation between pairs

correlation_matrix = [1,  c_12, c_13; 
                      c_12, 1,  c_23; 
                      c_13, c_23  1];
correlated_randoms = chol(correlation_matrix,'lower') ...
    *randn(num_names,N);
u = normcdf(correlated_randoms');

% alternative way to generate u ~ U(0,1) 
%u = copularnd('Gaussian',correlation_matrix,num_samples); % staistical toolbox

% sample default time
default_time_unsorted = -log( 1- u )/hazard_rate;

default_time = sort(default_time_unsorted,2);

payoff_time = T .^ ones(N, num_names);

is_payoff = zeros(N, num_names);

for i = 1:N
   
    if default_time(i,1) < t1
        is_payoff(i,1) = 1;
        payoff_time(i,1) = default_time(i,1);
    end
    
    if default_time(i,2) < t2
        is_payoff(i,2) = 1;
        payoff_time(i,2) = default_time(i,2);
    end
    
    if default_time(i,3) < T
        is_payoff(i,3) = 1;
        payoff_time(i,3) = default_time(i,3);
    end
    
end

%is_default_before_maturity = c1 | c2 | c3; %this is the 'or' operator

payoff = notional*(1-recovery_rate)* ...
         (    exp(-interest_rate*payoff_time(:,1)).*is_payoff(:,1) ...
            + exp(-interest_rate*payoff_time(:,2)).*is_payoff(:,2) ...
            + exp(-interest_rate*payoff_time(:,3)).*is_payoff(:,3));

% compute payment when spread is 1 bp
BASIS_POINT_CONVERSION_MULTIPLIER = 1/10000;
payment = notional*BASIS_POINT_CONVERSION_MULTIPLIER*...
               ( (1-exp(-interest_rate*payoff_time(:,3))))/interest_rate;

CDS_spread_bp = mean(payoff)/mean(payment);

disp('*** F2D Baskets Spread (bp) ***');
disp(CDS_spread_bp);

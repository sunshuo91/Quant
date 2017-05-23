%
% Problem 2: Valuation of Single-name CDS
%

clc; clear;

% Parameters
interest_rate = 0.1;
hazard_rate_1 = 200/10000; %calculate using specification of 200 basis points
hazard_rate_2 = 400/10000;
recovery_rate = 0.5;
time_to_maturity = 2; %years
number_of_samples = 1e6;
notional = 1; %notional amount insured


% simulate default time
u = rand(number_of_samples,1);

default_time = 3; 

if u > (1 - exp(-hazard_rate_1 - hazard_rate_2))
elseif u < (1 - exp(-hazard_rate_1))
	default_time = -log(1-u)/hazard_rate_1;
else
	default_time = 1 - (log(1-u) + hazard_rate_1)/hazard_rate_2;
end

% compute payoff
is_default_before_maturity = (default_time<time_to_maturity);
payoff = notional*(1-recovery_rate)*exp(-interest_rate*default_time).*...
                                                is_default_before_maturity;

% compute payment when spread is 1 bp
BASIS_POINT_CONVERSION_MULTIPLIER = 1/10000;
last_payment_time = min(default_time, time_to_maturity);
payment = BASIS_POINT_CONVERSION_MULTIPLIER*...
          notional*(1-exp(-interest_rate*last_payment_time))/interest_rate;

CDS_spread_bp = mean(payoff)/mean(payment);

disp('Problem 2: *********************');
disp('');
disp('*** CDS Spread (bp) ***');
disp(CDS_spread_bp);
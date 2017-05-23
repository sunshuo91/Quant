%
% Problem 1: Valuation of kth-to-Default CDS
%

clear;clc;

interest_rate = 0.1; %yearly, countinously compounded
hazard_rate = 200/10000;
recovery_rate = 0.5;
time_to_maturity = 5;
rho = 0.2; %gaussian copula
number_of_samples = 1e6;
number_of_names = 3;
notional = 1;

correlation_matrix = [1, rho, rho; 
                      rho, 1, rho
                      rho, rho, 1];

correlated_normals = chol(correlation_matrix,'lower')*randn(number_of_names,number_of_samples);
u = normcdf(correlated_normals');

default_time = -log( 1-u )/hazard_rate;


% Case 1: T1 < T2, T1 < T3, T1 < τ
c1 = (default_time(:,1) < time_to_maturity ) & (default_time(:,1) < default_time(:,2) ) & (default_time(:,1) < default_time(:,3) );
% Case 2: T2 < T1, T2 < T3, T2 < τ
c2 = (default_time(:,2) < time_to_maturity ) & (default_time(:,2) < default_time(:,1) ) & (default_time(:,2) < default_time(:,3) );
% Case 3: T3 < T1, T3 < T2, T3 < τ
c3 = (default_time(:,3) < time_to_maturity ) & (default_time(:,3) < default_time(:,2) ) & (default_time(:,3) < default_time(:,1) );
% Case 4: τ <T1 , τ < T2 and τ < T3
c4 = (default_time(:,1) > time_to_maturity ) & (default_time(:,2) > time_to_maturity) & (default_time(:,3) > time_to_maturity);

%get the last payment time and figure out if there is a default before
%maturity
is_default_before_maturity = c1 | c2 | c3; %this is the 'or' operator
last_payment_time = c1.*default_time(:,1) + c2.*default_time(:,2) + c3.*default_time(:,3)+ c4.*time_to_maturity;

% compute payoff
payoff = notional*(1-recovery_rate)* ...
           (exp(-interest_rate*last_payment_time).*is_default_before_maturity);

% compute payment when spread is 1 bp
BASIS_POINT_CONVERSION_MULTIPLIER = 1/10000;
payment = BASIS_POINT_CONVERSION_MULTIPLIER*...
       notional*( (1-exp(-interest_rate*last_payment_time)))/interest_rate;

      
CDS_spread_bp = mean(payoff)/mean(payment);

disp('Problem 1: *********************');
disp('');
disp('*** F2D Baskets Spread (bp) ***');
disp(CDS_spread_bp);



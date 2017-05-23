%
% Problem 2: Short Range Forwards
%

k_put = 1.9;
k_call = 1.9413;
T = 0.25;

r = 0.05;
rf = 0.05;
Q0 = 1.92;
Q_vol = 0.14;



power = 1:6;
N = 10.^power;

Contract_Price = zeros(length(N), 1);
Contract_SEM = zeros(length(N), 1);

for i = 1:length(N)
    Qt = Contract_Price_Random(Q0, r, rf, Q_vol, T, N(i));
    Contract_Payoff = Get_Contract_Payoff(Qt, k_put, k_call) * exp(-r * T);
    Contract_Price(i) = mean(Contract_Payoff);
    Contract_SEM(i) = std(Contract_Payoff)/sqrt(N(i));
end



format long g;
disp('Problem 2: *********************');
disp('');
fprintf('%12s %12s %12s \n', 'Nr of Paths', 'price','SEM');
fprintf('%12d %12g %12g \n', [N; Contract_Price'; Contract_SEM']);
disp('');disp('');

    
function Payoff = Get_Contract_Payoff(Qt, k_put, k_call)
    Payoff = max(k_put - Qt, 0) + min(k_call - Qt, 0);
end    


function Contract_Price = Contract_Price_Random(Q0, r, rf, Q_vol, T, N)
   Contract_Price = Q0 * exp(((r - rf) - Q_vol^2/2) * T + Q_vol*sqrt(T)*randn(N,1));
end



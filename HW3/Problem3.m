%
% Problem 3: Lookback Options
%

s0 = 50;
vol = 0.4;
r = 0.1;
T = 0.25;

power = 1:6;
N = 10.^power;

average_payoff = zeros(length(N), 1);
Option_SEM = zeros(length(N), 1);



num_steps = 300;
delta_T = T / num_steps;

num_paths_per_function_call = 1;

for i = 1:length(N)
    individual_payoff = zeros(N(i), 1);
    for j = 1:N(i) 
        path = GenerePaths(s0, r, vol, num_paths_per_function_call, num_steps, delta_T);
        individual_payoff(j) = mean(path) - min(path);
    end
    average_payoff(i) = mean(individual_payoff);
end

payoff = exp(-r*T) * average_payoff;

format long g;
disp('Problem 3: *********************');
disp('');
fprintf('%12s %12s\n', 'Nr of Paths', 'price');
fprintf('%12d %12g\n', [N; payoff']);
disp('');disp('');

 function Rep=GenerePaths(S0,r,sigma,NbTraj,NbStep,DeltaT)
 %Function to generate the paths.
 %S0: Initial price of the asset
 %r: Risk-free rate
 %sigma: Volatility
 %NbTraj: Number of simulated paths
 %NbStep: Number of time steps per path
 %DeltaT: Delta T for each step

 NuT = (r - sigma*sigma/2)*DeltaT;
 SqDelta = sqrt(DeltaT);
 DeltaW = SqDelta*randn(NbTraj, NbStep);
 Increments = NuT + sigma*DeltaW;
 LogPaths = cumsum([log(S0)*ones(NbTraj,1) , Increments] , 2);
 Rep = exp(LogPaths);
 end
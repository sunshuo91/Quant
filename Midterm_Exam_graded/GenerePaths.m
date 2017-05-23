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
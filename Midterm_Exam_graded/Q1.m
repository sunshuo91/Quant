clc;
clear;
%STU: exam total: 69/70 points. Nicely done!
%STU: this question: 20/20 points. Nice. :) 

S0 = 40;
r = 0.1;
vol = 0.3;
K = 42;
H = 38;

power = 1:4;
N = 10.^power;

T = 0.5; %Time to Maturity

steps = 500; %steps per path
deltaT = T/steps;

payoff_array = zeros(length(N),1);
SEM_array = zeros(length(N),1);

for i = 1: length(N)
    num_tra = N(i); % number of trajectories; 
    minima = zeros(num_tra,1); % minima st
    sT = zeros(size(minima)); %final st
    for j = 1:num_tra
        Path = GenerePaths(S0, r, vol,1,steps,deltaT);
        
        minima(j)=min(Path);
        sT(j) = Path(end);
        %STU: see my code for how to make this a little cleaner and more
        %direct. 
        if min(Path) >= H
            sT(j) = 0;
        end
        
    end
    
    Payoff = exp(-r*T)*max(sT-K,0);
    payoff_array(i) = mean(Payoff);
    SEM_array(i) = std(Payoff)/sqrt(num_tra);

end

disp('Question 1');
disp('Price      SEM');
disp([payoff_array SEM_array]);





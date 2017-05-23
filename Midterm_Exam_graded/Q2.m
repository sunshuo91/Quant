clc;
clear;
%STU: 14/15 points. 

r0 = 0.1;
a = 0.8;
b = 0.09;
dt = 1;
sigma = 0.1;

power = 1:6;
N = 10.^power;

rate = zeros(length(N),1);
prob = zeros(length(N),1);
rSEM = zeros(length(N),1);

for i = 1:length(N)
    rT = r0 + a*(b-r0)*dt + sigma*sqrt(r0)*randn(N(i),1);
    rate(i) = mean(rT)/r0;
    
    count = 0;
    for j = 1:length(rT)
        if rT(j)/r0 < 0.8
            count = count + 1;
        end
    end
    prob(i) = count/N(i);
    %STU: need std of the probability vector, not rT. 
    %-1 point. 
    rSEM(i) = std(prob)/sqrt(N(i));
end



format bank;
disp('     Nr of Paths      rate      probability     SEM');
disp([N', rate, prob, rSEM]);
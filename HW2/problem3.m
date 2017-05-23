%
% Problem 3: Straddle
%

k = 30;
s = linspace(10, 50, 41);

payoff = ones(1, length(s));
for n = 1:length(s)
    payoff(n) = straddle(s(n), k);
end

plot(s,payoff);

disp('Problem 3: *********************');
disp('');
disp('See plot output');
disp('');disp('');

function result = straddle(s, k)
    if s <= k
        result = k - s;
    else
        result = s - k;
    end
end

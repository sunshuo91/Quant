%
% Problem 3: Asset Returns
%

format short g;
year = (1:5)';
R = [0.05 0.1 -0.05 0 -.1]';

r = log(1 + R);


disp('Problem 3: *********************');
disp('');
disp('The corresponding continuously compounded returns are');
disp('          Time  Simple return  Log return');
disp([year R r]);
disp('');disp('');

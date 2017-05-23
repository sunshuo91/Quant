%
% Problem 4: Forward Rate
%

year = (1:5)';
rate = [0.02 0.03 0.037 0.042 0.045]';

FR = ones(1,length(year)-1);

for i = 2:length(year)
    FR(i-1) = (rate(i) * year(i) - rate(i-1) * year(i-1))/(year(i) - year(i-1));
end

disp('Problem 4: *********************');
disp('');
disp('The foward rates are');
disp('    Time      Forward rate');
disp([year(2:length(year)) FR']);
disp('');disp('');


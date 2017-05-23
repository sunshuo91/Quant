%
% Problem 4: Cheapest-to-Deliver Issue in Treasury Bond Futures
%
format short g;

file_name = 'HW_2_impliedRepo.xlsx';
xlRange = 'A2:B26';
num = xlsread(file_name,1,xlRange);

[Y,I] = max(num(:,2));
max_ID = num(I,1);

disp('Problem 4: *********************');
disp('');
disp('The max Im Repo Rate is');
disp(Y);
disp('The corresponding bond ID is');
disp(max_ID);
disp('');disp('');

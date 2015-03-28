clear;
clc;
A = [20,15,23;1,55,99;123,4,45];
disp(A);
B = ones(3,3);
B(find(A > 19)) = 0;
B(find(A < 50)) = 0;
disp(B);
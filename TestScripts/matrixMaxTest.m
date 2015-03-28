clear;
clc;
A = [11,5,7;91,99,3;4,1,4];
[minVal minLoc] = min(A(:));
disp(A);
x_shift = mod(minLoc - 1,3) - 1;
y_shift = floor((minLoc - 1)/3) - 1;
disp(x_shift);
disp(y_shift);

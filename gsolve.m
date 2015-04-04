%% solve for response curve given a set of pixel values, return response curve g and log film irradiance values for the observed pixels.
% assume Zmin = 0, Zmax = 255
% Arguments:
% Z(i,j)is the pixel values of pixel location number i in image j
% B(j)  is the log delta t, or log shutter speed for image j
% l     is lambda, the constant that determines the amount of smoothness
% w(z)  is the weighting function value for pixel value z
% Returns:
% g(z)  is the log exposure cooresponding to pixel value z
% lE(i) is the log film irradiance at pixel location i
function [g,lE] = gsolve(Z,B,l,w)

n = 256;
A = zeros(size(Z,1) * size(Z,2)+n+1,n + size(Z,1));
b = zeros(size(A,1), 1);

k = 1;                  % Include the data-fitting equations
for i = 1:size(Z,1)
  for j = 1:size(Z,2)
    wij = w(Z(i,j)+1);
    A(k,Z(i,j)+1) = wij;
    A(k,n+i) = -wij;
    b(k,1) = wij * B(j);
    k = k+1;
  end
end

A(k,129) = 1;           % Fix the curve by setting its middle value to 0
k = k+1;

for i = 1:n-2           % Include the smoothness equations
  A(k,i)=l*w(i+1); A(k,i+1)=-2*l*w(i+1); A(k,i+2)=l*w(i+1);
  k=k+1;
end

x = A\b;                % Solve the system using SVD

g = x(1:n);
lE = x(n+1:size(x,1));

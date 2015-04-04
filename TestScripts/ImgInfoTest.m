%% Select the ideal sample pixel
clear;
clc;
dirName = 'HDR_Photos';
disp(sprintf('2.> Select Sample nodes:'));
pixelNum=100;
pixel=zeros(pixelNum,2);
Z={};
file = dir([dirName '\\' '*.jpg']);
Z{1}=zeros(pixelNum,size(file,1));
Z{2}=zeros(pixelNum,size(file,1));
Z{3}=zeros(pixelNum,size(file,1));
disp(Z);
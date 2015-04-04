clear;
clc;
%% Z{} test
dirName='HDR_Photos';
file = dir([dirName '\\' '*.jpg']);
img = imread([dirName '\\' file(1).name]);
disp('Selecting pixels');
pixelNum = 100;
pixel=zeros(pixelNum,2);
photosNum = 8;
Z={}; %% [100 x 8 double]
Z{1}=zeros(pixelNum , photosNum);
Z{2}=zeros(pixelNum , photosNum);
Z{3}=zeros(pixelNum , photosNum);
disp(Z);
disp(Z{1});
% select 100 pixels randomly
for i = 1 : pixelNum
    tx = round(random('unif',1,size(img,1)));          % uniform random x coordinate and round it
    ty = round(random('unif',1,size(img,2)));          % uniform random y coordinate
    pixel(i,1)=tx;
    pixel(i,2)=ty;
    for j = 1 : size(file,1) %% all the images
        for k = 1:3
            Z{k}(i,j) = img{j}(tx,ty,k);
        end
    end
end
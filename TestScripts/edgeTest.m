%% edge test 
clear;
clc;
 %% edge extraction
 dirName='HDR_Photos';
 file = dir([dirName '\\' '*.jpg']);
 img = imread([dirName '\\' file(1).name]);
 img_E = uint8(zeros(size(img,1),size(img,2)));
 disp('Edge extraction:');
 img = {};
 disp(size(file,1));
 for k = 1 : size(file,1)   % 1 to 8 images
     img{k}= imread([dirName '\\' file(k).name]);
     img_C = edge(rgb2gray(img{k}),'canny');    % find edge
     img_E = img_E | img_C;                       % OR all the edges together
 end
 imshow(img_E);
 disp('edge test over');
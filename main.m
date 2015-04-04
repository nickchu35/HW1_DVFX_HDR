 % main file of the project
 clear;
 clc;
 disp('Start the HDR process');
 %% originally want to downsample first from 6000 x 4000 to 1500 x 1000 (1/4), but mind has changed
%  path = 'HDR_Photos/img2_';
%  sub = '.JPG';
%  small_s = '_small';
%  for i = 1:8
%      fs = [path int2str(i) sub];
%      im = imread(fs);
%      smallim = imresize(im,0.25);
%      fs = [path int2str(i) small_s sub];
%      imwrite(smallim, fs);
%  end
 %% Read in photos
 img1 = imread('HDR_Photos/img1_1.JPG'); 
 img2 = imread('HDR_Photos/img1_2.JPG');
 img3 = imread('HDR_Photos/img1_3.JPG'); 
 img4 = imread('HDR_Photos/img1_4.JPG'); 
 img5 = imread('HDR_Photos/img1_5.JPG'); 
 img6 = imread('HDR_Photos/img1_6.JPG'); 
 img7 = imread('HDR_Photos/img1_7.JPG');
 img8 = imread('HDR_Photos/img1_8.JPG');
 %% Images alignment
 shift = zeros(photosNum,2);
 disp('Start Alignment for img4 and img1'); shift(1,:) = align(img4,img1);
 disp('Start Alignment for img4 and img2'); shift(2,:) = align(img4,img2);
 disp('Start Alignment for img4 and img3'); shift(3,:) = align(img4,img3);
 % leave the number 4 empt
 disp('Start Alignment for img4 and img5'); shift(5,:) = align(img4,img5);
 disp('Start Alignment for img4 and img6'); shift(6,:) = align(img4,img6);
 disp('Start Alignment for img4 and img7'); shift(7,:) = align(img4,img7);
 disp('Start Alignment for img4 and img8'); shift(8,:) = align(img4,img8);
 %% Select sample pixels
 photosNum = 8;
 disp('Selecting pixels');
 file = dir(['HDR_Photos/img1_1.JPG']);
 shutter = [];
 for i = 1:photosNum
    shutter(i) = (2^i)/6400;
 end
 B=log(shutter);
 Wt = [0:1:127 127:-1:0];
 W = Wt./sum(Wt);
 pixelNum = 100;
 pixel=zeros(pixelNum,2);
 Z={};
 Z{1}=zeros(pixelNum,photosNum); [100 x 8 double]
 Z{2}=zeros(pixelNum,photosNum);
 Z{3}=zeros(pixelNum,photosNum);
 Z{4}=zeros(pixelNum,photosNum);
 Z{5}=zeros(pixelNum,photosNum);
 Z{6}=zeros(pixelNum,photosNum);
 Z{7}=zeros(pixelNum,photosNum);
 Z{8}=zeros(pixelNum,photosNum);
 for i = 1:pixelNum                % select 100 pixels
     for
     end
 end
 
 %% Recover response curve
 
 
 %% Recover HDR image (tone mapping)
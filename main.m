 % main file of the project
 clear;
 clc;
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


 

 
 
 %%
 
 
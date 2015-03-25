 % main file of the project
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
 %% Read l photos and transform to gray images
 img1 = imread('HDR_Photos/img1_1.JPG'); 
 img2 = imread('HDR_Photos/img1_2.JPG');
 img3 = imread('HDR_Photos/img1_3.JPG'); 
 img4 = imread('HDR_Photos/img1_4.JPG'); 
 img5 = imread('HDR_Photos/img1_5.JPG'); 
 img6 = imread('HDR_Photos/img1_6.JPG'); 
 img7 = imread('HDR_Photos/img1_7.JPG');
 img8 = imread('HDR_Photos/img1_8.JPG');
 img1_gray = rgb2gray(img1);
 img2_gray = rgb2gray(img2);
 img3_gray = rgb2gray(img3);
 img4_gray = rgb2gray(img4);
 img5_gray = rgb2gray(img5);
 img6_gray = rgb2gray(img6);
 img7_gray = rgb2gray(img7);
 img8_gray = rgb2gray(img8);

 

 
 
 %%
 
 
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
 %% edge extraction
 dirName='HDR_Photos';
 file = dir([dirName '/' '*.jpg']);
 img = imread([dirName '/' file(1).name]);
 img_E = uint8(zeros(size(img,1),size(img,2)));     % edges bit map
 disp('Edge extraction:');
 img = {};
 tic;
 for k = 1 : size(file,1)                           % 1 to 8 images
     img{k}= imread([dirName '/' file(k).name]);
     img_C = edge(rgb2gray(img{k}),'canny');        % find edge
     img_E = img_E | img_C;                         % OR all the edges together
 end
 disp('Edge extraction finished!');
 toc;
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
 photosNum = 8;
 shift = zeros(photosNum,2);
%  disp('Images aligning......');
%  tic;
%  disp('Start Alignment for img4 and img1'); shift(1,:) = align(img4,img1);
%  disp('Start Alignment for img4 and img2'); shift(2,:) = align(img4,img2);
%  disp('Start Alignment for img4 and img3'); shift(3,:) = align(img4,img3);
%  % leave the number 4 empt
%  disp('Start Alignment for img4 and img5'); shift(5,:) = align(img4,img5);
%  disp('Start Alignment for img4 and img6'); shift(6,:) = align(img4,img6);
%  disp('Start Alignment for img4 and img7'); shift(7,:) = align(img4,img7);
%  disp('Start Alignment for img4 and img8'); shift(8,:) = align(img4,img8);
%  disp('Images alignment finished......');
%  toc;
 %% set the shutter time
 shutter = [];
 for i = 1:photosNum
    shutter(i) = (2^i)/6400;
 end
 B=log(shutter);
 Wt = [0:1:127 127:-1:0];
 W = Wt./sum(Wt);
 %% Select sample pixels
 pixelNum = 100;
 pixel = zeros(pixelNum,2);
 tic;
 disp('Selecting pixels');
 Z = {};
 Z{1} = zeros(pixelNum,photosNum); %% [100 x 8 double]
 Z{2} = zeros(pixelNum,photosNum);
 Z{3} = zeros(pixelNum,photosNum);
 % select 100 pixels randomly
 for i = 1 : pixelNum
     tx = round(random('unif',1,size(img,1)));          % uniform random x coordinate and round it
     ty = round(random('unif',1,size(img,2)));          % uniform random y coordinate
     if ~img_E(tx,ty)                               % if not at edge
         pixel(i,1)=tx;
         pixel(i,2)=ty;
     end
     for j = 1 : size(file,1) %% all the images
         for k = 1:3
             Z{k}(i,j) = img{j}(tx,ty,k);
         end
     end
 end
 % select pixels by hand
 % TODO
 disp('Selecting pixels finished......');
 toc;
 %% Recover response curve
 disp('Recovering response curve!!!');
 tic;
 g = {};
 lE = {};
 for i = 1:3
     [g{i},lE{i}] = gsolve(Z{i}, B, 100, W);
 end
 plot(g{1}, [0:255], 'R', g{2}, [0:255], 'G', g{3}, [0:255], 'B');
 disp('Recovering response curve finished!');
 toc;
 %% Recover HDR image
 disp('Recovering the HDR image');
 tic;
 LoadFromPrevious = 1;  % directly load from previous or create a new one
 if LoadFromPrevious
     disp('Loading from previous EMap.mat');
     EnergyMap = load('EMap.mat');
 else
    EnergyMap = zeros(size(img1,1),size(img1,2),3);
    for i = 1:size(img1,1)
         for j = 1:size(img1,2)
             PixelsCount = i*size(img1,2)+j; % just to make sure it is still running
             if mod(PixelsCount,1000000) == 0
                disp(['Pixel count: ', PixelsCount/1000000 , ' million(s)']);
             end
             for k = 1:3
                 t1 = 0;
                 t2 = 0;
                 for now = 1:size(file,1)
                     Z = img{now}(i,j,k)+1;
                     t1 = t1+W(Z)*(g{k}(Z)-B(now));
                     t2 = t2+W(Z);
                 end
                 EnergyMap(i,j,k) = exp(t1/t2);
             end
         end
    end
    save('EMap','EnergyMap');
 end
 toc;
 disp('Recovering HDR image finished!');
 clear img; 
 %% Tone Mapping
 disp('Tone mapping!!!');
%  [L,result_G,result_L] = tonemap(g);
 disp('Tone mapping finished......');
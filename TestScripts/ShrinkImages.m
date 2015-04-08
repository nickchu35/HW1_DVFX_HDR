 path = 'HDR_Photos/Original/img1_';
 path2 = 'HDR_Photos/img1_';
 sub = '.JPG';
 small_s = '_small';
 for i = 1:8
     fs = [path int2str(i) sub];
     im = imread(fs);
     smallim = imresize(im,0.1);
     fs = [path2 int2str(i) sub];
     imwrite(smallim, fs);
 end
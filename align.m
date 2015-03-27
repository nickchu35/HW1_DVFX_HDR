function shift = align(im1,im2)
%%
% transform to grayscale imgs
img_gray1 = rgb2gray(im1);
img_gray2 = rgb2gray(im2);
% transform matrix to vector, and get the median of both imgs
th1 = median(double(img_gray1(:)));
th2 = median(double(img_gray2(:)));
% initialize MTB imgs, use logical 1 and 0
mtb1 = logical(zeros(size(img_gray1,1),size(img_gray1,2)));
mtb2 = logical(zeros(size(img_gray2,1),size(img_gray2,2)));
%%
% thresholding, size 1: column, 2: row
for i = 1 : size(img_gray1,1) 
    for j = 1 : size(img_gray1,2)
        if img_gray1(i,j) < th1
           mtb1(i,j) = 0; 
        elseif img_gray1( i, j) >= th1
           mtb1(i,j) = 1;
        end
        if img_gray2(i,j) < th2
           mtb2(i,j) = 0; 
        elseif img_gray2(i,j) >= th2
           mtb2(i,j) = 1;   
        end
    end
end
%%
% downsample, find best offset, upsample, find offset....
% downsample 6000x4000 - 3000x2000 - 1500x1000 - 750x500 - 375x250
pixel = size(img_gray1,1) * size(img_gray1,2); % number of pixels
error = zeros(3,3); % keep changing
shift = zeros(2,1); % x and y shift
for downsample_iteration = 1:4
   refDown = imresize(img_gray1,2^(downsample_iteration-5)); % downsample the reference image
   testDown = imresize(img_gray2,2^(downsample_iteration-5)); % downsample the reference image
   tempRef = zeros(size(refDown,1),size(refDown,2));
   tempTest = zeros(size(refDown,1),size(refDown,2));
   % check all the offsets error
   for i = -1:1:1
       for j = -1:1:1
           for x = 1:size(tempRef,1)
               for y = 1:size(tempRef,2)
                   if(x+i < 1 || x+i > size(img_gray1,1) || y+i < 1 || y+1 > size(img_gray1,2))
                       tempRef(x,y) = 0;
                       tempTest(x,y) = 0;
                   else
                       tempRef(x,y) = refDown(x,y);
                       tempTest(x,y) = testDown(x+i,y+j);
                   end
               end
           end
           diffMatrix = xor(tempRef,tempTest);
           error(2+i,2+j) = sum(sum(diffMatrix));
           disp(error);
       end
   end
   % get the min error's shift
   [minVal minLoc] = min(error(:));
   shift(1,1) = mod(minLoc - 1,3) - 1; % x shift
   shift(1,2) = floor((minLoc - 1)/3) - 1; % y shift
end
end
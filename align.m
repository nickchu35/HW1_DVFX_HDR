function shift = align(im1,im2)
img_gray1 = rgb2gray(im1);
img_gray2 = rgb2gray(im2);
% transform matrix to vector, and get the median of both imgs
th1 = median(double(img_gray1(:)));
th2 = median(double(img_gray2(:)));
% initialize MTB imgs
mtb1 = logical(zeros(size(img_gray1,1),size(img_gray1,2)));
mtb2 = logical(zeros(size(img_gray2,1),size(img_gray2,2)));
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
% figure, imshow(mtb1);
% figure, imshow(mtb2);
%%
% downsample, find best offset, upsample, find offset....
% downsample 6000x4000 - 3000x2000 - 1500x1000 - 750x500 - 375x250 -
% 188X125
error = zeros(3,3); % keep changing
shift = zeros(1,2); % x and y shift
for downsample_iteration = 1:5
   disp('iteration: '); disp(downsample_iteration);
   refDown = imresize(mtb1,2^(downsample_iteration - 5)); % downsample the reference mtb
   testDown = imresize(mtb2,2^(downsample_iteration - 5)); % downsample the test mtb
   exclusionRef = imresize(img_gray1,2^(downsample_iteration - 5));
   exclusionTest = imresize(img_gray2,2^(downsample_iteration - 5));
   % shift is 2 time bigger
   shift(1,1) = 2 * shift(1,1);
   shift(1,2) = 2 * shift(1,2);
   x_shift = shift(1,1);
   y_shift = shift(1,2);
   % shift the test mtb and exclusion
   for i = 1:size(refDown,1)
       for j = 1 :size(refDown,2)
           if(i-x_shift < 1 || i-x_shift > size(refDown,1) || j-y_shift < 1 || j-y_shift > size(refDown,2))
               testDown(i,j) = 0;
               exclusionTest(i,j) = 0;
           else
               testDown(i,j) = testDown(i-x_shift,j-y_shift);
               exclusionTest(i,j) = exclusionTest(i-x_shift,j-y_shift);
           end
       end
   end
   % set the exlusion map
   exclu_th1 = median(double(exclusionRef(:)));
   exclu_th2 = median(double(exclusionTest(:)));
   temp1 = logical(ones(size(exclusionRef,1),size(exclusionRef,2)));
   temp2 = logical(ones(size(exclusionRef,1),size(exclusionRef,2)));
   temp1(find(exclusionRef > (exclu_th1 - 4))) = 0;
   temp2(find(exclusionRef < (exclu_th1 + 4))) = 0;
   exclu1 = temp1 | temp2;
   temp1(:) = 1;
   temp2(:) = 1;
   temp1(find(exclusionTest > (exclu_th2 - 4))) = 0;
   temp2(find(exclusionTest < (exclu_th2 + 4))) = 0;
   exclu2 = temp1 | temp2;
   exclusionMap = exclu1 & exclu2;
   % temp matrix for later error calculating
   tempRef = zeros(size(refDown,1),size(refDown,2));
   tempTest = zeros(size(refDown,1),size(refDown,2));
   % check all the offsets error
   for i = -1:1:1
       for j = -1:1:1
           for x = 1:size(tempRef,1)
               for y = 1:size(tempRef,2)
                   if(x+i < 1 || x+i > size(refDown,1) || y+j < 1 || y+j > size(refDown,2))
                       tempRef(x,y) = 0;
                       tempTest(x,y) = 0;
                   else
                       tempRef(x,y) = refDown(x,y);
                       tempTest(x,y) = testDown(x+i,y+j);
                   end
               end
           end
           diffMatrix = xor(tempRef,tempTest);
           % ANDing with exclusionMap
           diffMatrix = diffMatrix & exclusionMap;
           error(2+i,2+j) = sum(sum(diffMatrix));
       end
   end
   % get the min error's shift
   [minVal minLoc] = min(error(:));
   shift(1,1) = shift(1,1) + (mod(minLoc - 1,3) - 1); % x shift
   shift(1,2) = shift(1,2) + (floor((minLoc - 1)/3) - 1); % y shift
   disp('error: ');
   disp(error);
   disp('shift:');
   disp(shift);
   disp('over');
end
end
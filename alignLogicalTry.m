im1 = imread('HDR_Photos/img1_6.JPG'); 
im2 = imread('HDR_Photos/img1_7.JPG');
im1 = imresize(im1,0.1);
im2 = imresize(im2,0.1);
% imshow(im1);
% figure, imshow(im2);
img_gray1 = rgb2gray(im1);
img_gray2 = rgb2gray(im2);
% figure, imshow(img_gray1);
% figure, imshow(img_gray2);
% transform matrix to vector, and get the median of both imgs
% th1 = median(double(img_gray1(:)));
% th2 = median(double(img_gray2(:)));
disp(th1);
disp(th2);
% initialize MTB imgs
mtb1 = zeros(size(img_gray1,1),size(img_gray1,2));
mtb2 = zeros(size(img_gray2,1),size(img_gray2,2));
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
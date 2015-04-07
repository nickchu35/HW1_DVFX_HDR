%% Do the actual shifting of pixels
function tempImg = shiftimg(img, shiftamount)
xs = shiftamount(1,1);
ys = shiftamount(1,2);
if xs ~= 0 && ys ~= 0 % need to shift
    tempImg = zeros(size(img,1),size(img,2));
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            if(i + xs > 0 && j + ys > 0 && i + xs <= size(img,1) && j + ys <= size(img,2))
                tempImg(i,j) = img(i + xs,j + ys);
            end
        end
    end
else
    tempImg = img;
end
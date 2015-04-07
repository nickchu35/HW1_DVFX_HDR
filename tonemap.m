function [L,result_G,result_L] = tonemap(EnergyMap)
%load EMap;
a=0.5;
level=20;
phi=8;
xlon= 0.001;
%% Tonemapping
% EnergyMap=exp(EnergyMap);
Lw=0.2126.*EnergyMap(:,:,1)+0.7152.*EnergyMap(:,:,2)+0.0722.*EnergyMap(:,:,3);
img_h=size(Lw,1);
img_w=size(Lw,2);
tmp=log(Lw+1);
avgLw=exp(sum(tmp(:))/(img_h*img_w));
L=a*Lw./avgLw;

blurred={};
for s=1:level
    H = fspecial('gaussian',31,s-1+eps);
    blurred{s}= imfilter(L,H,'symmetric');
end

%%
tmp=(2^phi)*a;
sk=zeros(img_h,img_w);
for i=1:img_h
    for j=1:img_w
        dis=1;
        for s=1:level-1
            dis=(blurred{s}(i,j)-blurred{s+1}(i,j))/(tmp/s^2+blurred{s}(i,j));
            if abs(dis)<xlon
                sk(i,j)=s;
                break;
            end
        end
        if sk(i,j)==0
            sk(i,j)=level;
        end
    end
end

%% Global
LG=[];
Lwhite=10;
for i=1:img_h
    for j=1:img_w
        LG(i,j)=L(i,j)*(1+L(i,j)/Lwhite^2)/(1+L(i,j));
    end
end
result_G=zeros(img_h,img_w,3);
result_G(:,:,1)=EnergyMap(:,:,1)./Lw.*LG;
result_G(:,:,2)=EnergyMap(:,:,2)./Lw.*LG;
result_G(:,:,3)=EnergyMap(:,:,3)./Lw.*LG;
imwrite(result_G,'result_G.bmp');
figure, imshow(result_G);
%% Local
LR=[];
for i=1:img_h
    for j=1:img_w
        LR(i,j)=L(i,j)/(1+blurred{sk(i,j)}(i,j));
    end
end
result_L=zeros(img_h,img_w,3);
result_L(:,:,1)=EnergyMap(:,:,1)./Lw.*LR;
result_L(:,:,2)=EnergyMap(:,:,2)./Lw.*LR;
result_L(:,:,3)=EnergyMap(:,:,3)./Lw.*LR;
imwrite(result_L,'result_L.bmp');
figure, imshow(result_L);
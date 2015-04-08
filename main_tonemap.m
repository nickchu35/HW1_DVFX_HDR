 clear;
 clc;
%%  Tone mapping
 disp('Tone mapping!!!');
 disp('Loading EMap.mat......');
 EnergyMap = cell2mat(struct2cell(load('EMap.mat')));
 imshow(EnergyMap);
 disp('Loading EMap.mat finished.');
 tic;
 [L,result_G,result_L] = tonemap(EnergyMap);
 toc;
 disp('Tone mapping finished......');
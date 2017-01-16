%   The code was written by Kun Zhan, Jinhui Shi
%   $Revision: 1.0.0.0 $  $Date: 2014/12/20 $ 10:30:18 $

%   Reference:
%   K. Zhan, J. Shi, J. Teng, Q. Li, M. Wang, F. Lu, 
%   "Linking synaptic computation for image enhancement"
%   Neurocomputing, 2017

% close all;
clear
addpath(genpath(pwd));
K = 6;
Contrast = ones(K,1);   Spatial_frequency = Contrast; 
    Gradient = Contrast;    JND = Contrast;
for k = 1 : K
    if k ==1
        I = imresize(imread('cameraman.tif'),2,'bilinear');
    elseif k == 2
        I = imread('tire.tif');
    elseif k == 3
        I = imread('boys.jpg');
    elseif k == 4
        I = imread('deer.jpg');
    elseif k == 5
        I = imread('flower.png');
    else
        I = imread('sweden.jpg');
    end
    V = rgb2v(I);
    V_flm = LSCN(V);
    [Contrast(k,1), Spatial_frequency(k,1), Gradient(k,1)] ...
        = QEvaluation(V_flm);
    JND(k,1) = JND_zhan2(V_flm);
    figure,imshow([I v2rgb(I,V_flm)]);
end
display([Contrast, Spatial_frequency, Gradient JND])

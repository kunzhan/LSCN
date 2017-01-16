function [lc, SF, MG] = QEvaluation(I)
%   The code was written by Kun Zhan, Jinhui Shi
%   $Revision: 1.0.0.0 $  $Date: 2014/11/21 $ 16:58:08 $
%   I: Enhenced image to be evaluated
%   lc, SF and MG denotes
%       local contrast, spatial frequency, and mean gradient respectively.

%   Reference:
%   [1]. K Zhan, J Teng, J Shi, Q Li, M Wang, 
%   "Feature-linking model for image enhancement," 
%   Neural Computation, vol. 28, no. 6, pp. 1072--1100, 2016.
%   [2]. De Vries F P P. 
%   "Automatic, adaptive, brightness independent contrast enhancement,"
%   Signal Processing, 21(2): 169-182, 1990
%   [3]. Eskicioglu A M, Fisher P S. 
%   "Image quality measures and their performance"
% 	IEEE Transactions on Communications, 43(12): 2959-2965, 1995.
%   [4]. Bai X, Zhang Y. 
%   "Enhancement of microscopy mineral images through constructing 
%   alternating operators using opening and closing based toggle operator"
%   Journal of Optics, 16(12): 125407, 2014.

I = double(I);
[M, N] = size(I); Tp = M*N;

%% local contrast
lm = imfilter(I, ones(3)/9, 'symmetric');
lv = imfilter(I.^2, ones(3)/9, 'symmetric') - lm.^2; 
lc = lv./(lm + eps);
lc = mean2(abs(lc));

%% spatial frequency
RF = diff(I,1,2); 
Row_Freq = sqrt(sum(sum(RF.^2))/Tp);
CF = diff(I,1,1); 
Column_Freq = sqrt(sum(sum(CF.^2))/Tp);
SF = sqrt(Row_Freq^2 + Column_Freq^2);

%% mean gradient
[Fx,Fy] = gradient(I);
G = sqrt(Fx.^2 + Fy.^2);
MG = mean2(G);
end

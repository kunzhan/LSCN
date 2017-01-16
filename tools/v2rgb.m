function Io = v2rgb(I,V)
%   The code was written by Jicai Teng, Jinhui Shi, Kun Zhan
%   $Revision: 1.0.0.0 $  $Date: 2014/12/11 $ 19:30:16 $

%   Reference:
%   K Zhan, J Teng, J Shi, Q Li, M Wang, 
%   "Feature-linking model for image enhancement," 
%   Neural Computation, vol. 28, no. 5, pp. , 2016.

[~,~,hei] = size(I);
if hei == 1
    Io = V;
else
    Io = rgb2hsv(I);
    Io(:,:,3) = im2double(V);
    Io = uint8(hsv2rgb(Io) .* 255);
end
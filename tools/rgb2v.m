function Iv = rgb2v(I)
%   The code was written by Jicai Teng, Jinhui Shi, Kun Zhan
%   $Revision: 1.0.0.0 $  $Date: 2014/12/11 $ 19:20:56 $

%   Reference:
%   K Zhan, J Teng, J Shi, Q Li, M Wang,
%   "Feature-linking model for image enhancement," 
%   Neural Computation, vol. 28, no. 5, pp. , 2016.

I = uint8(I);
[~,~,hei] = size(I);
if hei == 1
    Iv = I;
else
    hsv = rgb2hsv(I);
    V = hsv(:,:,3);
    Iv = uint8(V .* 255);
end
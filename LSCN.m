
%   Reference:
%   K. Zhan, J. Shi, J. Teng, Q. Li, M. Wang, F. Lu, 
%   "Linking synaptic computation for image enhancement"
%   Neurocomputing, 2017

function I1 = LSCN(Im)
    %% Linking Synaptic Computation Network
    Im = padarray(Im,[1 1],'symmetric');
    I = im2double(Im);
    [m,n] = size(I);
    %% initialization
    S = I + 1/255;
    sumY = 0; mn=m*n; l = 1; f = 0.01; beta = 0.01; delta = 1/255; V_theta = 0.001;
    r = 0.04; k = [r r r; r 1 r; r r r];
    L = zeros(m,n); U = L; Y = L; YY = L;
    % initial threshold
    R = 1;
    M = imsmooth(S, R, 0.2);
    E = 8.*(M-S).*(1-S);
    Emin = min(min(E));
    E = E - Emin + 1+ 2./255;
    %% network iteration
    while sumY < mn
        L = l.*L + conv2(Y,k,'same');        
        U = f.*U + S.*(1 + beta.*L);
        E = E - delta + V_theta.*Y;
        Y = double(U > E);
        YY = double(YY | Y);
        sumY = sum(sum(YY));
    end
    %% output
    I1 = GrayStretch(uint8(255*mat2gray(L)),0.98);
    I1 = I1(2:end-1,2:end-1);
end


    

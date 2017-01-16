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
    E = 9.*(M-S).*(1-S);
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
function M = imsmooth(S, R, k)
    [hei, wid] = size(S);
    N = boxfilter(ones(hei, wid), R); 
    mu_w = boxfilter(S, R) ./ N;
    sigma_w = boxfilter(S.*S, R) ./ N;
    var_I = sigma_w - mu_w .* mu_w;
    k = var_I ./ (var_I + k); 
    M = mu_w + k.*(S - mu_w);
end
function GS = GrayStretch(I,Per)
    [m,M] = FindingMm(I,Per);
    GS = uint8((double(I)-m)./(M-m)*255);
end
function [minI,MaxI] = FindingMm(I,Per)
    h = imhist(I);
    All = sum(h);
    ph = h ./ All;
    mth_ceiling = BoundFinding(ph,Per);
    Mph=fliplr(ph')';
    Mth_floor = BoundFinding(Mph,Per);
    Mth_floor = 256 - Mth_floor + 1;
    ConstraintJudge = @(x,y) sum(h(x:y))/All >= Per;
    Difference = zeros(256,256) + inf;
    for m = mth_ceiling:-1:1
        for M = Mth_floor:256
            if (h(m) > 0 )&&(h(M) > 0)
                if ConstraintJudge(m,M)
                    Difference(m,M) = M - m;
                end
            end
        end
    end
    minD = min(Difference(:));
    [m, M] = find(Difference==minD);
    minI = m(1) - 1;
    MaxI = M(1) - 1;
end
function m_ceiling = BoundFinding(ph,Per)
    cumP = cumsum(ph);
    n = 1;
    residualP = 1-Per;
    while cumP(n) < residualP
        n = n + 1;
    end
    m_ceiling = n;
end
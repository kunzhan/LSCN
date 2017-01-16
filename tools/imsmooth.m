function M = imsmooth(S, R, k)
[hei, wid] = size(S);
N = boxfilter(ones(hei, wid), R); 
mu_w = boxfilter(S, R) ./ N;
sigma_w = boxfilter(S.*S, R) ./ N;
var_I = sigma_w - mu_w .* mu_w;
k = var_I ./ (var_I + k); 
M = mu_w + k.*(S - mu_w);
end
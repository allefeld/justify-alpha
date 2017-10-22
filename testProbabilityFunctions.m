function [p, alphas, ns] = testProbabilityFunctions(E, dMu, dSigma)

% event probabilities and conditional probabilities
% as functions of significance level and sample size
%
% p = testProbabilityFunctions(E, dMu, dSigma)
%
% Calls testProbabilities with different values of alpha and n. The result
% is of the same type as that of testProbabilities, but each field is a
% two-dimensional array, corresponding to the significance levels `alphas`
% along the first dimension and the sample sizes `ns` along the second
% dimension. Results are cached, i.e. if the same parameters are specified
% again, calculations are not repeated but results loaded.

% range of significance levels and sample sizes
alphas = (sin(linspace(-pi/2, pi/2, 301)) + 1) / 2; % denser at the ends
ns = [2 3 5 7 10 20 30 50 70 100];

% check whether results have been computed before
filename = sprintf('tpf_%g_%g_%g.mat', E, dMu, dSigma);
if exist(filename, 'file')
    fprintf('loading\n')
    s = load(filename);
    if isequal(s.alphas, alphas) && isequal(s.ns, ns)
        p = s.p;
        return
    else
        fprintf('cache is outdated\n')
    end
end

% compute probabilities for range of significance levels and sample sizes
% results are collected in an array of structs
for i = 1 : numel(alphas)
    for j = 1 : numel(ns)
        a(i, j) = testProbabilities(E, dMu, dSigma, alphas(i), ns(j));      %#ok<AGROW>
    end
end

% repack from array of structs to struct of arrays
fn = fieldnames(a);
p = struct;
for i = 1 : numel(fn)
    p.(fn{i}) = reshape([a.(fn{i})], size(a));
end

% save results
save(filename, 'p', 'alphas', 'ns')



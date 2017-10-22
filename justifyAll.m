clear, close all

scenarios = scenario;
parfor i = 1 : numel(scenarios)
    [E, dMu, dSigma] = scenario(scenarios{i});
    [p, alphas, ns] = testProbabilityFunctions(E, dMu, dSigma);
end


% Does optimizing a (likelihood-ratio) test for information gain lead to
% Bayesian model selection?
% Does optimizing a test statistic for information gain lead to
% likelihood-ratio?
% Can different objective functions be unified via Rényi divergence?
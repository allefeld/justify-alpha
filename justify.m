function justify(prevalence, effectMean, effectPrecision)

% trying to justify my alpha
%
% justify(prevalence, effectMean, effectPrecision)
%
% The computations are based on a prior on / population distribution of
% effect sizes, which is a mixture of a delta function at zero for the
% zero-effect subpopulation and a normal distribution for the non-zero
% subpopulation. The effect size measure is Cohen's d. Accordingly, there
% are three parameters:
%   E:            probability that there is a non-zero effect (prevalence)
%   dMu, dSigma:  normal distribution parameters of non-zero effects
%
% Parameters are set according to different scenarios: 'small', 'medium',
% and 'large' values of
%   prevalence:         E = 0.2, 0.5, 0.8
%   effectMean:         dMu = 0.2, 0.5, 0.8
%   effectPrecision:    dMu / dSigma = 0.1, 1, 10
%
% Statistics are calculated as a function of significance level alpha and
% sample size n.
%
% Based on the prior / population distribution and the test parameters,
% the performance of a two-sided one-sample t-test against 0 is evaluated,
% using both probabilities of true/false positives/negatives and
% conditional probabilities, as well as objective functions.

if nargin < 1
    prevalence = 'medium';
end
if nargin < 2
    effectMean = 'large';
end
if nargin < 3
    effectPrecision = 'large';
end

% parameters organized in scenarios
switch prevalence
    case 'small'
        E = 0.2;
    case 'medium'
        E = 0.5;
    case 'large'
        E = 0.8;
end
switch effectMean
    case 'small'
        dMu = 0.2;
    case 'medium'
        dMu = 0.5;
    case 'large'
        dMu = 0.8;
end
switch effectPrecision
    case 'small'
        dSigma = dMu / 0.1;
    case 'medium'
        dSigma = dMu / 1;
    case 'large'
        dSigma = dMu / 10;
end

fprintf('justify %s %s %s\n', prevalence, effectMean, effectPrecision)
fprintf('        %g %g %g\n', E, dMu, dSigma)


% compute or load
filename = sprintf('justified_%s_%s_%s.mat', prevalence, effectMean, effectPrecision);
if ~exist(filename, 'file')
    % compute statistics for range of significance levels and sample sizes
    alphas = 0 :0.005: 1;
    ns = [2 5 10 20 50 100];
    for i = 1 : numel(alphas)
        for j = 1 : numel(ns)
            p(i, j) = testProbabilities(E, dMu, dSigma, alphas(i), ns(j));  %#ok<AGROW>
        end
    end
    % unpack fields of struct array into arrays
    fn = fieldnames(p);
    for i = 1 : numel(fn)
        x = reshape([p.(fn{i})], size(p));                                  %#ok<NASGU>
        eval([fn{i} ' = x;'])
    end
    clear fn i j p x
    % save
    save(filename)
else
    load(filename)
end


% plot results
% basic statistics
stats = {'TP'  'FP'  'P'   ''
         'FN'  'TN'  'N'   ''
         'TPR' 'FPR' 'PPV' 'FDR'
         'FNR' 'TNR' 'FOR' 'NPV'}';
% plotStats(stats, alphas, ns)
% objectives
% – a positive result: P
% – a true positive result: TP
% – a true result: TP + TN (accuracy)
% – optimal information gain: mutual information
MI = TP .* log2(TP ./ E ./ P) + FP .* log2(FP ./ Z ./ P) ...
   + FN .* log2(FN ./ E ./ N) + TN .* log2(TN ./ Z ./ N);
% – optimal information gain per sample
MIps = bsxfun(@rdivide, MI, ns);
objectives = {'P'       'TP' 'TP + TN - FP - FN'
              'TP + TN' 'MI' 'MIps'}';
plotStats(objectives, alphas, ns, 'max')
ylim([0 max(MIps(:))])  % fix MIps scaling
set(gcf, 'Name', [prevalence ' ' effectMean ' ' effectPrecision]);

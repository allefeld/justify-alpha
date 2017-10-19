function p = testProbabilities(E, dMu, dSigma, alpha, n)

% event probabilities and conditional probabilities in a hypothesis test
%
% p = testProbabilities(E, dMu, dSigma, alpha, n)
%
% calculations assume a prior on / population distribution of effect sizes
% which is a delta / normal mixture
%   E:        size of the non-zero subpopulation (prevalence)
%   dMu:      mean Cohen's d in the non-zero subpopulation 
%   dSigma:   standard deviation of Cohen's d in the non-zero subpopulation
%
% measurements are assumed to be normally distributed
% parameters of the one-sample two-sided t-test
%   alpha:    bound on the false positive rate
%   n:        sample size
%
% result p is a struct with fields
% unconditional probabilities of a
%   TP:   true positive
%   FP:   false negative
%   P:    positive
%   FN:   false negative
%   TN:   true negative
%   N:    negative
%   E:    non-zero effect
%   Z:    zero effect
% probabilities conditioned on outcome (P, N)
%   TPR:  true positive rate (sensitivity, power, recall)
%   FPR:  false positive rate (Type I error rate)
%   FNR:  false negative rate (Type II error rate)
%   TNR:  true negative rate (specificity)
% probabilities conditioned on effect (E, Z)
%   PPV:  positive predictive value (precision)
%   FDR:  false discovery rate
%   FOR:  false omission rate
%   NPV:  negative predictive value
%
% terminology follows & extends
% https://en.wikipedia.org/wiki/Positive_and_negative_predictive_values


% two-sided one-sample t-test
% critical value
tc = tinv(1 - alpha/2, n - 1);
% rejection probability as a function of true effect d
RP = @(d) nctcdf(-tc, n - 1, d * sqrt(n)) + 1 - nctcdf(tc, n - 1, d * sqrt(n));

% probability that there is a zero effect
Z = 1 - E;

% probability of a false positive
FP = Z * RP(0);         % it should hold RP(0) = alpha
% probability of a true positive
ds = linspace(dMu - 5 * dSigma, dMu + 5 * dSigma, 1001);
TP = E * trapz(ds, normpdf(ds, dMu, dSigma) .* RP(ds));

% probability of a true negative
%   given there is no effect, there can be a false positive or a true negative
%   FP + TN = Z
TN = Z - FP;

% probability of a false negative
%   given there is an effect, there can be a true positive or a false negative
%   TP + FN = E
FN = E - TP;

% probability of a positive
P = TP + FP;
% probability of a negative
N = FN + TN;

% true positive rate
TPR = TP / E;
% false negative rate
FNR = FN / E;
% false positive rate
FPR = FP / Z;           % it should hold FPR = alpha
% true negative rate
TNR = TN / Z;

% positive predictive value
PPV = TP / P;
% false omission rate
FOR = FN / N;
% false discovery rate
FDR = FP / P;
% negative predictive value
NPV = TN / N;

% result
p = struct('TP', TP, 'FP', FP, 'P', P, 'FN', FN, 'TN', TN, 'N', N, ...
    'E', E, 'Z', Z, 'TPR', TPR, 'FPR', FPR, 'FNR', FNR, 'TNR', TNR, ...
    'PPV', PPV, 'FDR', FDR, 'FOR', FOR, 'NPV', NPV);
if nargout == 0
    printTestProbabilities(p)
    clear p
end


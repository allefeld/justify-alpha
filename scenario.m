function [E, dMu, dSigma] = scenario(label)

% define effect size distribution scenarios
%
% [E, dMu, dSigma] = scenario(label)
%   'label' is a three-character string where each character is 's'
%   (small), 'm' (medium), or 'l' (large). The characters specify the
%   parameters of the effect size distribution along three dimensions:
%     label(1) = prevalence:            E = 0.2, 0.5, 0.8
%     label(2) = effect mean:           dMu = 0.2, 0.5, 0.8
%     label(3) = effect precision:      dSigma / dMu = 0.1, 1, 10
%
% scenarios = scenario()
%   With this syntax, a cell array containing the single-argument strings
%   for all 27 scenarios is returned.

if nargin == 0
    scenarios = (1 : 27) - 1;
    labels = 'sml';
    prevalence = labels(mod(scenarios, 3) + 1);
    effectMean = labels(mod(floor(scenarios / 3), 3) + 1);
    effectPrecision = labels(mod(floor(scenarios / 9), 3) + 1);
    scenarios = cellstr([prevalence ; effectMean ; effectPrecision]');
    E = scenarios;
    return
end

switch label(1)
    case 's'
        E = 0.2;
    case 'm'
        E = 0.5;
    case 'l'
        E = 0.8;
    otherwise
        error('no scenario "%s"!', label)
end

switch label(2)
    case 's'
        dMu = 0.2;
    case 'm'
        dMu = 0.5;
    case 'l'
        dMu = 0.8;
    otherwise
        error('no scenario "%s"!', label)
end

switch label(3)
    case 's'
        dSigma = dMu / 0.1;
    case 'm'
        dSigma = dMu / 1;
    case 'l'
        dSigma = dMu / 10;
    otherwise
        error('no scenario "%s"!', label)
end

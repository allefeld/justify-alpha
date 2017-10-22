function justify(objective, E, dMu, dSigma)

% trying to justify my alpha
%
% justify(objective, E, dMu, dSigma)
% justify(objective, scenario)

if nargin == 0
    close all
    justify(@oMI, 'lll')
%     justify('p.TP + p.TN', 'msm')
    return
end

if nargin == 2
    label = E;
    [E, dMu, dSigma] = scenario(E);
    label = sprintf('%s %g %g %g', label, E, dMu, dSigma);
else
    label = sprintf('%g %g %g', E, dMu, dSigma);
end
fprintf('justify %s\n', label)

% obtain probabilities
[p, alphas, ns] = testProbabilityFunctions(E, dMu, dSigma);

% compute objective
switch class(objective)
    case 'char'
        o = eval(objective);
    case 'function_handle'
        o = objective(p);
        objective = func2str(objective);
    otherwise
        error('unknown type of objective!')
end

% optimize
[~, ind] = max(o);
ind2 = sub2ind(size(o), ind, 1 : numel(ns));

% plot objective and optimization
figure('Name', ['objective ' label])
set(gcf,'units','normalized','outerposition',[0 0 1 1])

subplot(1, 2, 1)
plot(alphas, o)
hold all
plot(alphas(ind), o(ind2), 'k.')
xlim([0 1])
title('objective function')
ylabel(objective)
xlabel('\alpha')
leg = strsplit(sprintf('n = %d\n', ns), '\n');
leg = leg(1 : end - 1);
legend(leg, 'Location', 'Best')

subplot(1, 2, 2)
plot(ns, alphas(ind), 'k.-')
xlim([0, ns(end) + ns(1)])
title('optimal \alpha')
xlabel('n')
ylabel('\alpha')
    
% plot probabilities
figure('Name', ['probabilities ' label])
set(gcf,'units','normalized','outerposition',[0 0 1 1])
stats = {'p.TP'  'p.FP'  'p.P'   ''
         'p.FN'  'p.TN'  'p.N'   ''
         'p.TPR' 'p.FPR' 'p.PPV' 'p.FDR'
         'p.FNR' 'p.TNR' 'p.FOR' 'p.NPV'}';
for i = 1 : numel(stats)
    if isempty(stats{i})
        continue
    end
    subplot(size(stats, 1), size(stats, 2), i)
    s = eval(stats{i});
    plot(alphas, s)
    hold all
    plot(alphas(ind), s(ind2), 'k.')
    title(stats{i})
    axis([0 1 0 1])
end
xlabel('\alpha')
legh = legend(leg);
set(legh, 'Position', [0.92 0.15 0.06 0.10])

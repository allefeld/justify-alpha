function plotStats(stats, alphas, ns, opt)

if nargin < 4
    opt = 'none';
end

figure
set(gcf,'units','normalized','outerposition',[0 0 1 1])
for i = 1 : numel(stats)
    if isempty(stats{i}), continue, end
    subplot(size(stats, 2), size(stats, 1), i)
    
    s = evalin('caller', stats{i});
    plot(alphas, s)
    xlim([0 1])
    ylim([0 max(1, max(s(:)))])
    title(stats{i})
    
    hold all
    switch opt
        case 'max'
            [~, ind] = max(s);
        case 'min'
            [~, ind] = max(s);
        otherwise
            continue
    end
    fprintf('%s:\n', stats{i})
    for j = 1 : numel(ind)
        plot(alphas(ind(j)), s(ind(j), j), 'k.')
        fprintf('  %d\t%g\n', ns(j), alphas(ind(j)))
    end
end
xlabel('\alpha')
leg = strsplit(sprintf('n = %d\n', ns), '\n');
legh = legend(leg(1 : end - 1));
set(legh, 'Position', [0.92 0.15 0.06 0.10])
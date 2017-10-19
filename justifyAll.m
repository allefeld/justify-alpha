clear, close all

values = {'small', 'medium', 'large'};
for i = 1 : numel(values)
    for j = 1 : numel(values)
        for k = 1 : numel(values)
            justify(values{i}, values{j}, values{k})
            drawnow
        end
    end
end


% Does optimizing a (likelihood-ratio) test for information gain lead to
% Bayesian model selection?
% Does optimizing a test statistic for information gain lead to
% likelihood-ratio?
% Can different objective functions be unified via Rényi divergence?
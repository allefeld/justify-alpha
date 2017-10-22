function MI = oMI(p)

% objective: mutual information between true state (E/Z) and test result (P/N)
%
% MI = oMI(p)

MI = p.TP .* log2(p.TP ./ p.E ./ p.P) + p.FP .* log2(p.FP ./ p.Z ./ p.P) ...
   + p.FN .* log2(p.FN ./ p.E ./ p.N) + p.TN .* log2(p.TN ./ p.Z ./ p.N);

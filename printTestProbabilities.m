function printTestProbabilities(p)

fprintf('\n  event probabilities and marginals\n')
fprintf('         eff.    z.e. \n')
fprintf('pos.    %6.4f  %6.4f  %6.4f      TP   FP   P\n', p.TP, p.FP, p.P)
fprintf('neg.    %6.4f  %6.4f  %6.4f      FN   TN   N\n', p.FN, p.TN, p.N)
fprintf('        %6.4f  %6.4f              E    Z \n', p.E, p.Z)

fprintf('\n  conditioned on effect\n')
fprintf('         eff.    z.e. \n')
fprintf('pos.    %6.4f  %6.4f              TPR  FPR\n', p.TPR, p.FPR)
fprintf('neg.    %6.4f  %6.4f              FNR  TNR\n', p.FNR, p.TNR)

fprintf('\n  conditioned on outcome\n')
fprintf('         eff.    z.e. \n')
fprintf('pos.    %6.4f  %6.4f              PPV  FDR\n', p.PPV, p.FDR)
fprintf('neg.    %6.4f  %6.4f              FOR  NPV\n', p.FOR, p.NPV)

fprintf('\n')



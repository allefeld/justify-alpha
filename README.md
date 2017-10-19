# justify-alpha

Discussions of null hypothesis significance testing (NHST) often critizise the common significance level of α = 0.05 for being arbitrary, and call instead for a weighting of the costs and benefits of false and true positives (false and true negatives). Recent examples from the "p-value wars" include Benjamini et al. (*Redefine statistical significance*, 2017)

> We agree that the significance threshold selected for claiming a new discovery should depend on the prior odds that the null hypothesis is true, the number of hypotheses tested, the study design, the relative cost of Type I versus Type II errors, and other factors that vary by research topic.

and Lakens et al. (*Justify your alpha*, 2017)

> Ideally, the decision of where to set the alpha level for a study should be based on statistical decision theory, where costs and benefits are compared against a utility function (Neyman & Pearson, 1933; Skipper, Guenther, & Nass, 1967). Such an analysis can be expected to differ based on the type of study being conducted: for example, analysis of a large existing dataset versus primary data collection relying on hard-to-obtain samples. Science is necessarily diverse, and it is up to scientists within specific fields to justify the alpha level they decide to use.

Unfortunately, such calls are seldomly accompanied by concrete practical instructions on how to do so.

This repository contains a number of Matlab functions to aid in a first step towards "justifying your alpha". It is a work in progress, covering only a few specific scenarios, but it should already be helpful in testing various cost or utility functions and getting a feeling for their practical consequences.

***

This software was developed under Matlab R2015a, but appears to also work with Octave 4.0.3. It is copyrighted © 2017 by Carsten Allefeld and
released under the terms of the GNU General Public License, version 3 or later.

Comments, criticism, and contributions are welcome!


%% Train and test the classifiers

%% Upper face
% In this script use the parameters from Params section at the beginning
setupKnnClassifTests_UpperFace

% Knn (upper)
runKnnClassifTests__sameSubj_UpperFace
runKnnClassifTests__newSubj_UpperFace
runKnnClassifTests__newSpecies_UpperFace

%% Lower face
setupKnnClassifTests_lowerFace

% Knn (lower)
runKnnClassifTests__sameSubj_LowerFace
runKnnClassifTests__newSubj_LowerFace
runKnnClassifTests__newSpecies_LowerFace


%% Results analysis
% The following are different kinds of analysis that may be done on the
% basis of the results

% Summarize all sensitivity for KNN tests run
computeSensitivity_finalResults_upperFace
computeSensitivity_finalResults_lowerFace

% Holdout (80/20) validation for new species
runHoldoutValidation_newSpecies

% Compute the generalization performance subject-wise for each class 
% (and not, for example, video-wise)
analyzeClassifTests_sameSubj
analyzeClassifTests_newSubj

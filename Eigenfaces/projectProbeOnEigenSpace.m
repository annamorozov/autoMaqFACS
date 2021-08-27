function probeFeatureVec = projectProbeOnEigenSpace(probeImg, meanImgVec, eigVectors)

%probeImg = AU_1_2_FramesTbl_fromDBs_allSubj.imgCell{1,1};  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normalize the probe
normProbe = probeImg - meanImgVec;

% Project the probe image into the subspace to generate the feature vectors
probeFeatureVec = eigVectors' * normProbe;
function [resMatSavePath, eigfSampleSaveDirPath] = generateKnnTestResPaths(resSaveDir, varargin)
% Generate the paths for the classification results of all the sets

% Optional args: 'requestedExplVar', 'numNeighbors', 'distanceMetric'
% requestedExplVar: value btw 0-1. To calculate the "knee" value pass 0 to 'requestedExplVar'

%% Parse the input

minArgs=1;
maxArgs=7;
narginchk(minArgs,maxArgs)

p = inputParser;

addRequired(p,'resSaveDir',@ischar);

defaultReqExplVar = 0.95;
checkReqExplVarFmt = @(x) (x >= 0) && (x <= 1);
addParameter(p,'requestedExplVar',defaultReqExplVar,checkReqExplVarFmt);

defaultNumNeighbors = 4;
checkNumNeighborsFmt = @(x) ismember(x,1:max(x));  % Natural number check
addParameter(p,'numNeighbors',defaultNumNeighbors,checkNumNeighborsFmt);

defaultDistanceMetric= 'euclidean';
checkDistanceMetricFmt = @(x) ischar(x);
addParameter(p,'distanceMetric',defaultDistanceMetric,checkDistanceMetricFmt);

parse(p,resSaveDir,varargin{:});

if ~isempty(p.UsingDefaults)
   disp('Using defaults: ');
   disp(p.UsingDefaults);
end

%% Construct the names

resName = '';
if p.Results.requestedExplVar ~= 0
    resName = sprintf('nPC_expl_var_%d_neighbNum_%d_%s', (p.Results.requestedExplVar)*100, p.Results.numNeighbors, p.Results.distanceMetric);
else
    resName = sprintf('nPC_expl_var_knee_neighbNum_%d_%s', p.Results.numNeighbors, p.Results.distanceMetric);
end

eigfSampleSaveDir = sprintf('%s_eigf_1st_iter', resName);
resMatName = sprintf('%s.mat', resName);

eigfSampleSaveDirPath = fullfile(resSaveDir, eigfSampleSaveDir);
resMatSavePath = fullfile(resSaveDir, resMatName);


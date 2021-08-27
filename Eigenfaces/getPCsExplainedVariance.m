function [reqVarPC, kneePC, kneeExplVar] = getPCsExplainedVariance(eigVals, imgsNum, isShow, requestedExplVar)
    % Get the variability of the top eigenvectors
    % The bigger the value - the bigger the variability
    
    %% Defaults
    if nargin < 4   % requestedExplVar
        requestedExplVar = 0.95;
    end  
    %% 

    CVals = zeros(1,length(eigVals));    % Allocate a vector same length as Vals
    CVals(1) = eigVals(1);
    for i = 2:length(eigVals)            % Accumulate the eigenvalue sum
        CVals(i) = CVals(i-1) + eigVals(i);
    end
    CVals = CVals / sum(eigVals);        % Normalize total sum to 1.0
        
    iArray = find(CVals <= requestedExplVar);
    reqVarPC = length(iArray);           % Number of PCs to get the requested explained variance
    
    [kneePC, ~] = knee_pt(CVals);        % Number of PCs to get the "knee" point of the curve
    kneeExplVar = CVals(kneePC);
   
    if isShow
        figure
        plot(CVals);                         % Plot the cumulative sum
        
        hold on;
        plot(kneePC, CVals(kneePC), 'r*');   % Mark the "knee" point
        
        ylim([0 1]);                         % Set Y-axis limits to be 0-1
        xlim([0 imgsNum]);
        
        title('Explained variance by the PCs');
        xlabel('all the PCs');
        ylabel('explained variance %');
    end

end
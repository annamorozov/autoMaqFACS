function [Vectors, num_good] = normalizeAndFilterEigVecs(Vectors, Values, imagesNum, numvecs, epsilon)
% Normalize Vectors to unit length, kill vectors corr. to tiny evalues.

    fprintf(1,'Normalizing and filtering eigen vectors...\n');
    num_good = 0;
    
    for i = 1:imagesNum
        Vectors(:,i) = Vectors(:,i)/norm(Vectors(:,i));
        if Values(i) < epsilon
          % Set the vector to the 0 vector; set the value to 0.
          Values(i) = 0;
          Vectors(:,i) = zeros(size(Vectors,1),1);
        else
          num_good = num_good + 1;
        end;
    end;
    if (numvecs > num_good)
        fprintf(1,'Warning: numvecs is %d; only %d exist.\n',numvecs,num_good);
        numvecs = num_good;
    end;
    Vectors = Vectors(:,1:numvecs);
    
    fprintf(1,'Finished normalization and filtering.\n');

end
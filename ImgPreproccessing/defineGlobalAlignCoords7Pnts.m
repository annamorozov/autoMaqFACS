function defLandmarks = defineGlobalAlignCoords7Pnts(imgHeight, imgWidth)
% Define global coordinates of 7 landmark points

defLeftEyeCoord  = [0.42*imgWidth, 0.3*imgHeight; 0.48*imgWidth, 0.3*imgHeight];
defRightEyeCoord = [0.52*imgWidth, 0.3*imgHeight; 0.58*imgWidth, 0.3*imgHeight];

defLeftMouthCorner  = [0.44*imgWidth, 0.55*imgHeight];
defRightMouthCorner = [0.56*imgWidth, 0.55*imgHeight];
defMouthCoord       = [0.5*imgWidth, 0.5*imgHeight];

defLandmarks = [defLeftEyeCoord; defRightEyeCoord;...
    defLeftMouthCorner; defRightMouthCorner; defMouthCoord];
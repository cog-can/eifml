function [xPosterior,PPosterior]= EkfUpdate(xPrior,PPrior,z,R,radarState)
    x_polar = MeasurementFunction(xPrior, radarState);
    H = MeasurementMatrix(xPrior, radarState);
    S = H * PPrior * H' + R;
    residue = z - x_polar;
    gain = PPrior * H' / S;

    xPosterior = xPrior + gain * residue;
    PPosterior = PPrior - gain * S * gain';
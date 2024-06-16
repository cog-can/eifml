function [posteriorMean,posteriorCovariance,gainX] = kalmanUpdate(priorMean,priorCovariance,z,H,R)
    S = H * priorCovariance * H' + R;
    residue = z - H * priorMean;

    gainX = priorCovariance * H' / S;
    posteriorMean = priorMean + gainX * residue;
    posteriorCovariance = priorCovariance - gainX * S * gainX';
end


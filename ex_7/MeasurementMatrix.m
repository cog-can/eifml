function [measMatrix]= MeasurementMatrix(state,radarState)
    x = state(1);
    y = state(2);
    radar_x = radarState(1);
    radar_y = radarState(2);
    delta_x = x - radar_x;
    delta_y = y - radar_y;
    r = sqrt(delta_x^2 + delta_y^2);

    measMatrix = zeros(2, 4);
    measMatrix(1, 1) = delta_x / r;
    measMatrix(1, 2) = delta_y / r;
    measMatrix(2, 1) = -delta_y / (delta_x^2 + delta_y^2);
    measMatrix(2, 2) = delta_x / (delta_x^2 + delta_y^2);
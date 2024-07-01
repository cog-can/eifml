function [label] = get_label(x, w)
    if length(x) < length(w)
        x = [x; 1];
    end

    if w.' * x >= 0
        label = 1;
    else
        label = 0;
    end
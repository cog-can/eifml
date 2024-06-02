function plot_comparison(x_axis, x_name, ml_estimates, map_estimates, plot_name)
    figure;
    plot(x_axis, ml_estimates, "Color", "Red", "Marker", "o");
   
    hold on;
    plot(x_axis, map_estimates, "Color", "Blue", "Marker", "*");
    xlabel(x_name);
    ylabel("Estimate of x");

    legend("ML estimate", "MAP estimate")
    title(plot_name)
end
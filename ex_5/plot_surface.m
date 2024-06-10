function plot_surface(priorMean, priorCovariance)
    range = -100;
    [X, Y] = meshgrid( ...
        linspace(-range, range, 100), ...
        linspace(-range, range, 100) ...
    );

    pdf_2d = mvnpdf([X(:) Y(:)], priorMean(1:2, :)', priorCovariance(1:2, 1:2));
    pdf_2d = reshape(pdf_2d, size(X));
    surf(linspace(-range, range, 100), linspace(-range, range, 100), pdf_2d);
    xlabel('X');
    ylabel('Y');
end
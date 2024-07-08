function [projected_data, eigenvectors_sorted] = pca(dataset, k)
    dataset_T = dataset.';
    cov_matrix = cov(dataset_T);

    [eigenvectors, eigenvalues] = eig(cov_matrix);
    eigenvalues = diag(eigenvalues);

    [eigenvalues_sorted, idx] = sort(eigenvalues, 'descend');
    eigenvectors_sorted = eigenvectors(:, idx);

    projection_matrix = eigenvectors_sorted(:, 1:k);
    projected_data = projection_matrix' * dataset;
end
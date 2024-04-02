function obj = drawunits (obj)
%-------------------------------------------------------------------------%
% DRAWING FUNCTION                                                        %
%-------------------------------------------------------------------------%

for k = 1:obj.numberUnits
    if obj.units{k}.H ~= 0
        delete(obj.units{k}.H);
    end
    % Form the upper left 2x2 submatrix of the covariance matrix from the eigenvalues and eigenvectors
    sub_matrix = obj.units{k}.weight(1:2,:) * (obj.units{k}.eigenvalue .* obj.units{k}.weight(1:2,:)');
    % For high-dimensional data sets add the minor eigendirections
    if obj.dataDimensionality ~= 2
         sub_matrix = sub_matrix + ...
            obj.units{k}.sigma_sqr/(obj.dataDimensionality - obj.units{k}.m) * ( eye(2) - obj.units{k}.weight(1:2,:) * obj.units{k}.weight(1:2,:)' );
    end
    % determine the eigenvectors and eigenvalues of this submatrix (dimension 2), 
    % use these to draw the projected ellipse (without drawing them as axes)
    [eigenvectors_new,eigenvalues_new] = eig(sub_matrix); 
    eigenvalues_new = diag(eigenvalues_new);
    [~, idx] = maxk(obj.units{k}.eigenvalue, 2);
    w = obj.units{k}.weight(1:2,idx);
    scale = sqrt(obj.units{k}.eigenvalue(idx));
    % Use the new eigenvalues and eigenvectors for the ellipsoids and the
    % original ones for the axes
    obj.units{k}.H = plot_ellipse(eigenvectors_new, sqrt(eigenvalues_new(1:2)), obj.units{k}.center(1:2), w, scale);
end
% Force the plot, equal to drawnow
pause(0.001)


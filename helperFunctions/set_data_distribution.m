function [p,units] =set_data_distribution(p,units,loop)
%-------------------------------------------------------------------------%
% FIRST PART OF MAIN LOOP: SET AND PLOT DATA DISTRIBUTION                 %
%-------------------------------------------------------------------------%
% exchange data distribution
    % plot data and show initial title
%     if loop == p.Change
%       p.shape = p.vortex_train;
%       [p.rows, p.columns2] = size(p.shape);
%       if(p.columns2 ~= p.columns)
%         error('Data dimensionality has to be the same for D1 and D2.');
%       end
%       %for a = 1:p.N
%       %   units{a}.mt = zeros(units{a}.outdimension, 1);
%       %   units{a}.Dt = 0.99;
%       %end
%     end
    if p.plt == 1
        p.handler = figure;
        %plot(p.shape(:,1), p.shape(:,2), 'c.');
        scatter(p.shape(:,1), p.shape(:,2),5,'o','MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
        hold on;
        scatter(p.GT(:,1), p.GT(:,2),15,'o','filled','r')
        %p.ht = title( sprintf('t = %i', p.t_show) );
        xlabel('X');
        ylabel('Y');
        axis equal;
        axis manual;
        for k = 1:p.N
            %Ellipsoid graphic handle
            units{k}.H = plot_ellipse(units{k}.weight(1:2,1:2), sqrt(abs(units{k}.eigenvalue(1:2))), units{k}.center(1:2));
            %Text inside the each ellipsoid
%             units{k}.HT = text('Position', units{k}.center(1:2),...
%                                'String', sprintf('%u', k),      ...
%                                'Color', 'r',                    ...
%                                'Visible', 'on');
        end
        drawnow;
    end



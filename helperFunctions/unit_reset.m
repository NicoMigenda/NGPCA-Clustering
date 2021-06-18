function [p, units] = unit_reset(p,units,minIndex)
%-------------------------------------------------------------------------%
% FOURTH PART OF MAIN LOOP: UNIT RESET                                    %
%-------------------------------------------------------------------------%

    units{minIndex}.center = p.x;
    units{minIndex}.outdimension = p.StartDim;
    units{minIndex}.weight = orth(rand(p.columns, units{minIndex}.outdimension));
    units{minIndex}.eigenvalue = repmat(p.lambdaSum / p.N, units{minIndex}.outdimension, 1);
    units{minIndex}.sigma = p.sigmaSum / p.N;
    units{minIndex}.mt = zeros(units{minIndex}.outdimension, 1);
    units{minIndex}.y = zeros(units{minIndex}.outdimension, 1);
    p.allAges(minIndex) = p.ageMax;
    units{minIndex}.t = 0;
    fprintf( 'Resetting unit: %i\n', minIndex );







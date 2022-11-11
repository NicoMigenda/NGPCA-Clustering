function saveNet( p, units )
%-------------------------------------------------------------------------%
% SAVE FUNCTION                                                           %
%-------------------------------------------------------------------------%

fid = fopen( p.filename, 'w' );
fprintf( fid, '%i %i\n', p.N, p.columns );
for k = 1:p.N
    fprintf( fid, '%i\n', p.columns );
    fprintf( fid, '%f\n', units{k}.center );
    fprintf( fid, '%i %i\n', p.columns, units{k}.outdimension );
    for k2 = 1:units{k}.outdimension
        fprintf( fid, '%f ', units{k}.weight(:,k2) );
        fprintf( fid, '\n' );
    end
    fprintf( fid, '%f\n', units{k}.eigenvalue );
    fprintf( fid, '%f\n', units{k}.sigma );
    fprintf( fid, ' 0\n1\n1\n' );
end
fclose( fid );
end

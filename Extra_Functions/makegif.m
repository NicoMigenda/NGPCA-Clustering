function makegif(Parameter, loop)
    % Write GIF 
    frame = getframe(Parameter.handler); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    filename = strcat('.\Results\gif\', Parameter.filename(1:2), '_', Parameter.logTerms, '_', Parameter.v_control, '_', Parameter.c_type, '_' ...
               , Parameter.LR, '.gif');
    if loop == Parameter.t_show 
      imwrite(imind, cm, filename, 'gif', 'Loopcount',inf,'DelayTime',1); 
    else 
      imwrite(imind, cm,filename,'gif','WriteMode','append','DelayTime',1); 
    end 
    
    %function save_plot(Parameter,loop)
    %    name = split(Parameter.filename,".");
    %    path_name = strcat('.\Results\paper\', name{1}, '_', string(loop));
    %    export_fig(path_name, '-pdf', '-transparent')
    %end
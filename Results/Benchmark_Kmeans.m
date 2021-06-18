clear variables
close all

load h512_with_gt.mat

for i = 1: 100
    [label, Center] = kmeans(data,16);

    len = size(gt,1);
    for z = 1:len
        x = gt(z,:);
        for k = 1:size(Center,1)
           x_c = sqrt(sum((x - Center(k,:)) .^ 2));   
           p.r(k,:) = [k, x_c];
        end
        p.r = sortrows(abs(p.r), 2);
        winner(z) = p.r(1,1);
    end

    nmi(i) = normalizedmi([1:len], sort(winner));
end
mean(nmi)
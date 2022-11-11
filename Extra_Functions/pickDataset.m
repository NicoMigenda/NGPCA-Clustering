function [data, gt, number, dim, dataset, reps, label] = pickDataset(dd) 
    switch dd
        case 1
            dataset = 's1_with_gt';
            load s1_with_gt.mat;
            number = 15;
            dim = 2;
            reps = 4;
            label = 's1-label.pa';
        case 2
            dataset = 's2_with_gt';
            load s2_with_gt.mat;
            number = 15;
            dim = 2;
            reps = 4;
            label = 's2-label.pa';
        case 3
            dataset = 's3_with_gt';
            load s3_with_gt.mat;
            number = 15;
            dim = 2;
            reps = 4;
            label = 's3-label.pa';
        case 4
            dataset = 's4_with_gt';
            load s4_with_gt.mat;
            number = 15;
            dim = 2;
            reps = 4;
            label = 's4-label.pa';
        case 5
            dataset = 'a1_with_gt';
            load a1_with_gt.mat;
            number = 20;
            dim = 2;
            reps = 4;
            label = 'a1-label.pa';
        case 6
            dataset = 'a2_with_gt';
            load a2_with_gt.mat;
            number = 35;
            dim = 2;
            reps = 4;
            label = 'a2-label.pa';
        case 7
            dataset = 'a3_with_gt';
            load a3_with_gt.mat;
            number = 50;
            dim = 2;
            reps = 4;
            label = 'a3-label.pa';
        case 8
            dataset = 'b1_with_gt';
            load b1_with_gt.mat;
            number = 100;
            dim = 2;
            reps = 2;
            label = 'b1-label.pa';
        case 9
           dataset = 'b2_with_gt';
            load b2_with_gt.mat;
            number = 100;
            dim = 2;
            reps = 2;
            label = 'b2-label.pa';
        case 10
           dataset = 'b3_with_gt';
            load b3_with_gt.mat;
            number = 100;
            dim = 2;
            reps = 2;
            label = 'b2-label.pa';
        case 11
           dataset = 'u1_with_gt';
           load u1_with_gt.mat;
           number = 8;
           dim = 2;
           reps = 4;
           label = 'u1-label.pa';
        case 12
           dataset = 'h32_with_gt';
           load h32_with_gt.mat;
           number = 16;
           dim = 4;
           reps = 50;
           label = 'h32-label.pa';
        case 13
           dataset = 'h64_with_gt';
           load h64_with_gt.mat;
           number = 16;
           dim = 4;
           reps = 40;
           label = 'h64-label.pa';
        case 14
           dataset = 'h128_with_gt';
           load h128_with_gt.mat;
           number = 16;
           dim = 4;
           reps = 40;
           label = 'h128-label.pa';
        case 15
           dataset = 'h256_with_gt';
           load h256_with_gt.mat;
           number = 16;
           dim = 4;
           reps = 40;
           label = 'h256-label.pa';
       case 16
           dataset = 'h512_with_gt';
           load h512_with_gt.mat;
           number = 16;
           dim = 4;
           reps = 40;
           label = 'h512-label.pa';
       case 17
           dataset = 'h1024_with_gt';
           load h1024_with_gt.mat;
           number = 16;
           dim = 4;
           reps = 40;
           label = 'h1024-label.pa';
    end
end


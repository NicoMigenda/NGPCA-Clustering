function [data, gt, number, dim, dataset] = pickDataset(dd) 
    switch dd
        case 1
            dataset = 's1';
            load s1_with_gt.mat;
            number = 15;
            dim = 2;
        case 2
            dataset = 's2';
            load s2_with_gt.mat;
            number = 15;
            dim = 2;
        case 3
            dataset = 's3';
            load s3_with_gt.mat;
            number = 15;
            dim = 2;
        case 4
            dataset = 's4';
            load s4_with_gt.mat;
            number = 15;
            dim = 2;
        case 5
            dataset = 'a1';
            load a1_with_gt.mat;
            number = 20;
            dim = 2;
        case 6
            dataset = 'a2';
            load a2_with_gt.mat;
            number = 35;
            dim = 2;
        case 7
            dataset = 'a3';
            load a3_with_gt.mat;
            number = 50;
            dim = 2;
        case 8
            dataset = 'b1';
            load b1_with_gt.mat;
            number = 100;
            dim = 2;
        case 9
           dataset = 'b2';
            load b2_with_gt.mat;
            number = 100;
            dim = 2;
        case 10
           dataset = 'b3';
            load b3_with_gt.mat;
            number = 100;
            dim = 2;
        case 11
           dataset = 'u1';
           load u1_with_gt.mat;
           number = 8;
           dim = 2;
        case 12
           dataset = 'h32';
           load h32_with_gt.mat;
           number = 16;
           dim = 10;
        case 13
           dataset = 'h64';
           load h64_with_gt.mat;
           number = 16;
           dim = 10;
        case 14
           dataset = 'h128';
           load h128_with_gt.mat;
           number = 16;
           dim = 10;
        case 15
           dataset = 'h256';
           load h256_with_gt.mat;
           number = 16;
           dim = 10;
       case 16
           dataset = 'h512';
           load h512_with_gt.mat;
           number = 16;
           dim = 10;
       case 17
           dataset = 'h1024';
           load h1024_with_gt.mat;
           number = 16;
           dim = 10;
    end
end


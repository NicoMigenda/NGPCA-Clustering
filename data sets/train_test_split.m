clear variables
clc
close all

rng(0)

data = csvread('rls.mat');
r = rand(4000,1);
dataTrain = data(r < 0.8,:);
dataTest =data(r >= 0.8,:);

clear variables
data = vortex(6*pi, 120, 20, 2000);
r = rand(2000,1);
dataTrain = data(r < 0.8,:);
dataTest =data(r >= 0.8,:);

clear variables
load('worms2D.mat');
r = rand(length(data),1);
dataTrain = data(r < 0.8,:);
dataTest =data(r >= 0.8,:);

clear variables
load('worms64D.mat');
r = rand(length(data),1);
dataTrain = data(r < 0.8,:);
dataTest =data(r >= 0.8,:);

clear variables
load('s1.mat');
r = rand(length(data),1);
dataTrain = data(r < 0.8,:);
dataTest =data(r >= 0.8,:);
clear r
clear data
save s1_split.mat

clear variables
load('s2.mat');
r = rand(length(data),1);
dataTrain = data(r < 0.8,:);
dataTest =data(r >= 0.8,:);
clear r
clear data
save s2_split.mat

clear variables
load('s3.mat');
r = rand(length(data),1);
dataTrain = data(r < 0.8,:);
dataTest =data(r >= 0.8,:);
clear r
clear data
save s3_split.mat

clear variables
load('s4.mat');
r = rand(length(data),1);
dataTrain = data(r < 0.8,:);
dataTest =data(r >= 0.8,:);
clear r
clear data
save s4_split.mat

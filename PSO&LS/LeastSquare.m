clc;clear;close all
%% data read
X1 = xlsread('aandb.xlsx',1); %drugi
X2 = xlsread('aandb.xlsx',2); %social-economic
Y = xlsread('aandb.xlsx',3);  %drugi+1
%% Least Square Method
X = [X1,X2];
p = X\Y; %coefficient
Y_predict = X*p;
%% to value the good or bad
SSE = sum((Y_predict-Y).^2);
MSE = SSE/length(X);
RMSE = sqrt(MSE);
y_av = sum(Y)/length(Y);
SST = sum((Y-y_av).^2);
R_square = 1-SSE/SST;
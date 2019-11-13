clc;clear;close all;
%% 初始化种群
N = 1000;                          % 初始种群个数
d = 4;                             % 空间维数
ger = 10000*d;                      % 最大迭代次数     
limit = [-10, 10];                % 设置位置参数限制
vlimit = [-(limit(2)-limit(1))/10,(limit(2)-limit(1))/10 ];  % 设置速度限制(位置上限的20%)
w = 1.4;                            % 惯性权重
c1 = 2;                             % 自我学习因子
c2 = 2;                             % 群体学习因子 
x = limit(1) + (limit(2) - limit(1)) * rand(N, d); %初始种群的位置
v = vlimit(2)*((rand(N, d)-0.5)/0.5);% 初始种群的速度(-vlimit~vlimit)

xm = x;                          % 每个个体的历史最佳位置
ym = zeros(1, d);                % 种群的历史最佳位置

fxm = 100000000+zeros(N, 1);               % 每个个体的历史最佳适应度
fym = 100000000;                           % 种群历史最佳适应度
%% 读入drugreports矩阵与各成分矩阵
drugreports = xlsread('drug.xlsx',1,'B2:H378');
W1 = xlsread('1.xlsx',1,'B2:H378');
W2 = xlsread('2.xlsx',1,'B2:H378');
W3 = xlsread('3.xlsx',1,'B2:H378');
W4 = xlsread('4.xlsx',1,'B2:H378');
%% 群体更新
iter = 1;%计数器
record = zeros(ger, 1);          % 记录器
while iter <= ger
     fx = euclidean_dis(x,W1,W2,W3,W4,drugreports) ; % 个体当前适应度
     for i = 1:N      
        if fxm(i) > fx(i)
            fxm(i) = fx(i);     % 更新个体历史最佳适应度
            xm(i,:) = x(i,:);   % 更新个体历史最佳位置
        end 
     end
    if fym > min(fxm)
        [fym, nmin] = min(fxm);   % 更新群体历史最佳适应度
        ym = xm(nmin, :);      % 更新群体历史最佳位置
     end
    v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% 速度更新
    % 边界速度处理
    v(v > vlimit(2)) = vlimit(2);
    v(v < vlimit(1)) = vlimit(1);
    x = x + v;% 位置更新
    % 边界位置处理
    x(x > limit(2)) = limit(2);
    x(x < limit(1)) = limit(1);
    record(iter) = fym;%最大值记录
    iter = iter+1;
end

%% 求Pearson系数
weight = ym; %最终的最优weight值
SE = weight(1)*W1+weight(2)*W2+weight(3)*W3+weight(4)*W4; %Social-Economic矩阵
for i=1:7
SE(:,i) = SE(:,i)/norm(SE(:,i));
end
for i=1:length(SE)
    s=corrcoef(drugreports(i,:)',SE(i,:)');%明天研究下pearson kendall spearman
    Pearson(i,:) = s(1,2);
end
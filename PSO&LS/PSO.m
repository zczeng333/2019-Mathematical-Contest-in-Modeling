clc;clear;close all;
%% ��ʼ����Ⱥ
N = 1000;                          % ��ʼ��Ⱥ����
d = 4;                             % �ռ�ά��
ger = 10000*d;                      % ����������     
limit = [-10, 10];                % ����λ�ò�������
vlimit = [-(limit(2)-limit(1))/10,(limit(2)-limit(1))/10 ];  % �����ٶ�����(λ�����޵�20%)
w = 1.4;                            % ����Ȩ��
c1 = 2;                             % ����ѧϰ����
c2 = 2;                             % Ⱥ��ѧϰ���� 
x = limit(1) + (limit(2) - limit(1)) * rand(N, d); %��ʼ��Ⱥ��λ��
v = vlimit(2)*((rand(N, d)-0.5)/0.5);% ��ʼ��Ⱥ���ٶ�(-vlimit~vlimit)

xm = x;                          % ÿ���������ʷ���λ��
ym = zeros(1, d);                % ��Ⱥ����ʷ���λ��

fxm = 100000000+zeros(N, 1);               % ÿ���������ʷ�����Ӧ��
fym = 100000000;                           % ��Ⱥ��ʷ�����Ӧ��
%% ����drugreports��������ɷ־���
drugreports = xlsread('drug.xlsx',1,'B2:H378');
W1 = xlsread('1.xlsx',1,'B2:H378');
W2 = xlsread('2.xlsx',1,'B2:H378');
W3 = xlsread('3.xlsx',1,'B2:H378');
W4 = xlsread('4.xlsx',1,'B2:H378');
%% Ⱥ�����
iter = 1;%������
record = zeros(ger, 1);          % ��¼��
while iter <= ger
     fx = euclidean_dis(x,W1,W2,W3,W4,drugreports) ; % ���嵱ǰ��Ӧ��
     for i = 1:N      
        if fxm(i) > fx(i)
            fxm(i) = fx(i);     % ���¸�����ʷ�����Ӧ��
            xm(i,:) = x(i,:);   % ���¸�����ʷ���λ��
        end 
     end
    if fym > min(fxm)
        [fym, nmin] = min(fxm);   % ����Ⱥ����ʷ�����Ӧ��
        ym = xm(nmin, :);      % ����Ⱥ����ʷ���λ��
     end
    v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% �ٶȸ���
    % �߽��ٶȴ���
    v(v > vlimit(2)) = vlimit(2);
    v(v < vlimit(1)) = vlimit(1);
    x = x + v;% λ�ø���
    % �߽�λ�ô���
    x(x > limit(2)) = limit(2);
    x(x < limit(1)) = limit(1);
    record(iter) = fym;%���ֵ��¼
    iter = iter+1;
end

%% ��Pearsonϵ��
weight = ym; %���յ�����weightֵ
SE = weight(1)*W1+weight(2)*W2+weight(3)*W3+weight(4)*W4; %Social-Economic����
for i=1:7
SE(:,i) = SE(:,i)/norm(SE(:,i));
end
for i=1:length(SE)
    s=corrcoef(drugreports(i,:)',SE(i,:)');%�����о���pearson kendall spearman
    Pearson(i,:) = s(1,2);
end
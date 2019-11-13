%% threshold_selection
% Attain best threshold through iteration process
clc;clear;
T=xlsread('2017_2xlsx'); %load data
threshold=1;   %threshold for breaking the iteration
T0=inf;
T1=mean(T);
[len,~]=size(T);
while(abs(T1-T0)>threshold)
    up=[];
    down=[];
    for i=1:len
        if(T(i)>T1)
            up=[up;T(i)];
        else
            down=[down;T(i)];
        end
    end
    %calculate the mean value of two part divided by the current threshold
    up_mean=mean(up);
    down_mean=mean(down);
    T0=T1;  %record last threshold
    T1=(up_mean+down_mean)/2;   %record current threshold
end
fprintf('the best threshold is: %e\n', T1);
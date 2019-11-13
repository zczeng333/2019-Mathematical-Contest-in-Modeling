close all;clear;clc
threshold=1462.3;   %threshold value (low)
% threshold=10118.6;  %threshold value (high)
year=3;   %years need to be predicted
step=0.25;
TDRC=xlsread('TDRC_gauss.xlsx','A1:H101');
center_pos=xlsread('kmeans_center.xlsx','B2:C101');
x=TDRC(1,:);
for i=1:year
    x=[x,i+2017];
end
[row,~]=size(TDRC);
notice=[];  %when UB meets threshold
warning=[]; %when center meets threshold
for i=2:60
    disp(i)
    data=TDRC(i,:)';
    [predict,UB,LB] = ARIMA_Predict(data,year);
    data_center=[data;predict]';
    data_UB=[data;UB]';
    xx=2010:step:(2017+year);
    center_predict=spline(x,data_center,xx);
    UB_predict=spline(x,data_UB,xx);
    center_after17=center_predict(1,(7/step+1):length(center_predict));
    UB_after17=UB_predict(1,(7/step+1):length(UB_predict));
    xx_after17=xx(1,(7/step+1):length(xx));
    figure(i)
    plot(x,data_center,'o',xx,center_predict);
    hold on;
    plot(x,data_UB,'o',xx_after17,UB_after17);
    flag_w=0;
    flag_n=0;
    for j=1:(length(xx)-7/step)
        if(center_after17(1)<threshold&&center_after17(j)>=threshold&&flag_w==0)
            warning=[warning;[i-1,center_pos(i-1,1),center_pos(i-1,2),xx_after17(1,j)]];
            flag_w=1;   %once record, no more further information to be recorded in warning matrix
        end
        if(UB_after17(1)<threshold&&UB_after17(j)>threshold&&flag_n==0)
            notice=[notice;[i-1,center_pos(i-1,1),center_pos(i-1,2),xx_after17(1,j)]];
            flag_n=1;   %once record, no more further information to be recorded in notice matrix
        end
    end
end
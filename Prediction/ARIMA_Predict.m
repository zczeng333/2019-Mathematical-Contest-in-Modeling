function  [predict,UB,LB] = ARIMA_Predict(y_ori,num)
%% ARIMA Model
Mdl = arima(3,0,1);
EstMdl = estimate(Mdl,y_ori);
res = infer(EstMdl,y_ori);
[yF,yMSE] = forecast(EstMdl,num,'Y0',y_ori);
UB = yF + 1.96*sqrt(yMSE);
LB = yF - 1.96*sqrt(yMSE);
predict = yF;

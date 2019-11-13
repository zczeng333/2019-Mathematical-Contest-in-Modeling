clc;clear;
% data=xlsread('kmeans_2010.xlsx','B2:C446');
% data=xlsread('kmeans_2011.xlsx','B2:C428');
% data=xlsread('kmeans_2012.xlsx','B2:C432');
% data=xlsread('kmeans_2013.xlsx','B2:C447');
% data=xlsread('kmeans_2014.xlsx','B2:C441');
% data=xlsread('kmeans_2015.xlsx','B2:C425');
% data=xlsread('kmeans_2016.xlsx','B2:C438');
% data=xlsread('kmeans_2017.xlsx','B2:C429');  
data=xlsread('Kmeans_again.xlsx','B2:C3479');
opts = statset('Display','final');
k=100;
[idx,C] = kmeans(data,k,'Distance','cityblock',...
    'Replicates',10,'Options',opts);
figure;
hold on
for i=1:k
    plot(data(idx==i,1),data(idx==i,2),'.',...
        'Color',[1/k*i,1-1/k*i,1/k*i],'MarkerSize',12)
end
hold on
plot(C(:,1),C(:,2),'kx','MarkerSize',7,'LineWidth',1)
title 'Result of Cluster Assignments and Centroids Using K-Means Algorithm'
xlabel 'Longitude'
ylabel 'Latitude '
hold off
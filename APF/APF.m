close all; clear all; clc
% [lon,lat]=meshgrid([-89:0.1:-75],[36.6:0.1:41.9]);
% u=sin(lat./6);v=sin(lon./6);
% m_proj('oblique','lat',[41.95,36.55],'long',[-89.04,-75.06],'aspect',0.75);
m_proj('robinson','lat',[36.55,41.95],'long',[-89.04,-75.06]);
m_coast('patch',[.9,.9,.9],'edgecolor','none');
m_grid('tickdir','out','yaxislocation','right','xaxislocation','top','xlabeldir','end','ticklength',.02);
m_coast('patch',[.7 .7 .7],'edgecolor','r');%画海岸线，【.7.7.7】是设置海岸线的颜色，‘r’设置为红色
hold on;
point_num=80;
Xrang =[36.55,41.95]; %lattitude represents the X 
Yrang =[-89.04,-75.06]; %lontitude represents the Y
X_point = linspace(Xrang(1),Xrang(2),point_num); %discrete points' X
Y_point = linspace(Yrang(1),Yrang(2),point_num); %discrete points' Y
for i=1:point_num  %Point is the array of discrete point
    for j=1:point_num
        Point((i-1)*point_num+j,1) = X_point(i);
        Point((i-1)*point_num+j,2) = Y_point(j);
    end
end
threshold_low = 0.04; %threshold_one
threshold_high = 0.05; %threshold_two
%A列为latitude，B列为longtitude，C列为指标
Analyze_Matrix = xlsread('SyntheticOpioid_analyze.xlsx',1,'A:C'); % When read the excel, it should be in descending order
%% Get the Resistant Matrix according to threshold_high
[row,~] = size(Analyze_Matrix); %Get row
for i=1:row %traverse the Analyze_Matrix
    if(Analyze_Matrix(i,3)<threshold_high)
        break;
    end
end
%Now i is the boundary_high
boundary_high = i;
Resistant_Matrix = Analyze_Matrix(1:boundary_high-1,:); %Resistance Point

%% Get the Attract Matrix according to threshold_low
for i=boundary_high:row
  if(Analyze_Matrix(i,3)<threshold_low)
        break;
    end
end  
%Now i is the boundary_low
boundary_low = i;
Attract_Matrix = Analyze_Matrix(boundary_high:boundary_low-1,:); %Attract Point

%% Get the Unreachable Matrix
Unreachable_Matrix = Analyze_Matrix(boundary_low:row,:); %Unreachable Point

%% traverse all the discrete point to get each point's force
for i=1:point_num^2
    [F(i,1),F(i,2)] = force(Attract_Matrix,Resistant_Matrix,Point(i,1),Point(i,2)); %The ith Point
    F_magnitude(i) = sqrt(power(F(i,1),2)+power(F(i,2),2));
    F_argument(i) = atan2(F(i,1),F(i,2));
end

%% plot
%  quiver(Point(:,1),Point(:,2),0.0001*F(:,1),0.0001*F(:,2));
lon=reshape(Point(:,2),point_num,point_num);
lat=reshape(Point(:,1),point_num,point_num);
lon=lon';
lat=lat';
u=reshape(F(:,1)./sqrt(F(:,1).*F(:,1)+F(:,2).*F(:,2)),point_num,point_num);
v=reshape(F(:,2)./sqrt(F(:,1).*F(:,1)+F(:,2).*F(:,2)),point_num,point_num);
% m_quiver(lon,lat,v./1000,u./1000,'r','linewidth',2,0);
m_quiver(lon,lat,u./7,v./7,0,'r','linewidth',1);
xlabel('Spread of SO in 2014','fontsize',15);
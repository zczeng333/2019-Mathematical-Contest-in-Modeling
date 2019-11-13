%%
%input: attract matrix (3*m); reject matrix(3*n), edges:xmin,xmax,ymin,ymax
%return: F(Fx,Fy)
function [Fx,Fy]=force(A,R,x,y)
	da=3;	%attract distance threshold
	dr=3;	%reject distance threshold
	Ka=1;	%coefficient of attract force
	Kr=1;	%coefficient of reject force
    [rowa,~]=size(A);
    [rowr,~]=size(R);
    Fx=0;
	Fy=0;
	for i=1:rowa
		dis=sqrt((A(i,1)-x)^2+(A(i,2)-y)^2);
		if(dis>da)
			ct=(A(i,1)-x)/dis;
			st=(A(i,2)-y)/dis;
			Fx=Fx+2*A(i,3)*da*ct;
			Fy=Fy+2*A(i,3)*da*st;
%             disp('1')
%             2*A(i,3)*da
		else
			Fx=Fx+2*A(i,3)*(A(i,1)-x);
			Fy=Fy+2*A(i,3)*(A(i,2)-y);
%             disp('2')
%             2*A(i,3)*dis
		end
	end
	for i=1:rowr
		dis=sqrt((R(i,1)-x)^2+(R(i,2)-y)^2);
		if(dis<=dr)
			Fx=Fx-R(i,3)*(1/dis-1/dr)/dis^3*(R(i,1)-x);
			Fy=Fy-R(i,3)*(1/dis-1/dr)/dis^3*(R(i,2)-y);
%             disp('3')
%             R(i,3)*(1/dis-1/dr)/dis^2
        end
    end
end
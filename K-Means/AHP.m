%% function AHP(A)
%input: comparision matrix A
%output: corresponding weight vector Q
function Q = AHP(A)
[m,n] = size(A);    %obtain size of matrix A
RI = [0,0,0.58,0.90,1.12,1.24,1.32,1.41,1.45,1.49,1.51];
R = rank(A);        %obtain the rank of A
[V,D] = eig(A);     %obtain eigenvalue D and eigenvector V
tz = max(D);
B = max(tz);        %max eigenvalue
[row,col] = find(D == B);   %obtain the corresponding position of the max eigenvalue
C = V(:,col);  %obtain the corresponding eigenvector of the max eigenvalue
CI = (B-n)/(n-1);
CR = CI/RI(1,n);
if CR < 0.10
    disp('CI = ');disp(CI);
    disp('CR = ');disp(CR);
    disp('Comparision maxtrix passes the consistency check, weight vector Q is as follow:');
    Q = zeros(n,1);
    for i = 1:n
        Q(i,1) = C(i,1)/sum(C(:,1));
    end
    disp(Q);
else
    disp('Comparision maxtrix A failed to pass the consistency check, please reconstruct A');
end
end



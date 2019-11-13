%fx = euclidean_dis(x,W1,W2,W3,W4,drugreports)
%x为N*4的矩阵
function fx = euclidean_dis(x,W1,W2,W3,W4,drugreports)
    [N,~] = size(x);
    for i=1:N %一个一个地计算欧氏距离
        weight = x(i,:); %1*4
        W5 = weight(1)*W1+weight(2)*W2+weight(3)*W3+weight(4)*W4;
        %接下来要计算drugreports矩阵和W5矩阵之间的欧式距离
        C = (W5-drugreports).^2;
        fx(i,:)=sqrt(sum(C(:)));
    end
end
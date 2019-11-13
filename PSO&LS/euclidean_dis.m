%fx = euclidean_dis(x,W1,W2,W3,W4,drugreports)
%xΪN*4�ľ���
function fx = euclidean_dis(x,W1,W2,W3,W4,drugreports)
    [N,~] = size(x);
    for i=1:N %һ��һ���ؼ���ŷ�Ͼ���
        weight = x(i,:); %1*4
        W5 = weight(1)*W1+weight(2)*W2+weight(3)*W3+weight(4)*W4;
        %������Ҫ����drugreports�����W5����֮���ŷʽ����
        C = (W5-drugreports).^2;
        fx(i,:)=sqrt(sum(C(:)));
    end
end
function index=RWSelect(V,m)
%��Roulette Wheel Selection��ѡ��m������
% Input:
%      V           -----����ѡ��Ⱥ��ÿ���������Ҫ��ָ��(����Ӧ�ȵ�)
%      m           -----ѡ��ĸ�����
% Output:
%      index       -----��ѡ��m�����λ������
%Tips:��VΪȫ������ʱ�����㷨��Ч�������ѡ�����;�����㷨������Ҫ��ָ�겻Ϊ0�ĸ�����ѡ��

    n=size(V,1);%����ѡ�ĸ�����
    if max(V)==0&min(V)==0%���V��ȫ�����������ѡ��
        index=ceil(rand(1,m)*n);
    else
        %����Ӧ��Ϊ0�ĸ����������ѡ��Χ
        temindex=find(V~=0);
        n=length(temindex);%����ѡ�ĸ�����Ŀ����
        V=V(temindex);

        index=zeros(1,m);
        %[V,I]=sort(V,'descend');
        V=cumsum(V)/sum(V);

        pp=rand(1,m);
        for i=1:m,
            for j=1:n,
                if pp(i)<V(j)
                    index(i)=j;
                    break
                end
            end
        end
        index=temindex(index);
    end
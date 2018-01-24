function index=RWSelect(V,m)
%用Roulette Wheel Selection法选择m个个体
% Input:
%      V           -----待挑选种群中每个个体的重要性指标(如适应度等)
%      m           -----选择的个体数
% Output:
%      index       -----挑选的m个体的位置索引
%Tips:当V为全零向量时，该算法无效，将随机选择个体;否则算法将从重要性指标不为0的个体中选择。

    n=size(V,1);%待挑选的个体数
    if max(V)==0&min(V)==0%如果V是全零向量，随机选择
        index=ceil(rand(1,m)*n);
    else
        %将适应度为0的个体驱逐出待选择范围
        temindex=find(V~=0);
        n=length(temindex);%待挑选的个体数目降低
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
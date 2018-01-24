
%% Statrt of Program
clc;clear;
close all
tic

%% 参数设定
SelMethod = 1;
CrossMethod = 1;

PopSize = 500;%种群数量
MaxIteration = 800; %最大迭代次数

CrossPercent = 80;%交叉比率
MutatPercent = 19;%变异比率
ElitPercent = 100-CrossPercent-MutatPercent;%精英比率

CrossNum = round(CrossPercent/100*PopSize); %交叉个数
if mod(CrossNum,2)~=0
    CrossNum = CrossNum - 1; %交叉个数设定为偶数
end
MutatNum = round(MutatPercent/100*PopSize);%变异个数
ElitNum = PopSize - CrossNum - MutatNum;%精英数量

%% Problem Satement
%种群数量保证多样性，每个个体实际上是一种方案，个体就是焊接序列12道工序
%所以单个种群长度12，起始工序和终止工序固定？
plen=19;
ser1=[8 9 14 18 4 2 3 5];
ser2=[1];
ser3=[];
% ser3=[6 10 12 13 15 16 17 11 19];
% ser4=[8 9];
% ser5=[4];
% ser6=[3];
% ser7=[14 18];
% ser8=[7];
% ser9=[6];
global A %生成关系矩阵
A = zeros(plen,plen);
costList = [18 23 23 26 26 6 26 27 7 6 8 4 4 8 5 4 4 13 8];
% costList = [19 7 9 26 26 9 16 13 4 4 4 4];
for i = ser1
    for j = ser2
        A(i,j)=1;A(j,i)=-1;
        for k = ser3
            A(j,k)=1;A(k,j)=-1;
            A(i,k)=1;A(k,i)=-1;
        end
    end
end
lenP = 0;
Pop = [];
while lenP<PopSize
    po = randperm(plen);
    count=1;
    for i = 1:plen-1
        for j = i+1:plen
            if A(po(i),po(j))~=0
                count=count*A(po(i),po(j));
            end
            if count==-1
                break;
            end
        end
        if count==-1
            break;
        end
    end
    if count==1
        Pop = [Pop;po];
        [lenP,~] = size(Pop);
    end
end

%% 初始化种群
Cost=[];
for i = 1:size(Pop,1)
    Cost = [Cost;GetCost(Pop(i,:),costList)];
end
[Cost Indx] = sort(Cost,'descend');
Pop = Pop(Indx,:);

%% Main Loop
MeanMat = [];
MinMat = [];

for Iter = 1:MaxIteration
    %% Elitism 保留精英
    ElitPop = Pop(1:ElitNum,:);
    
    %% CrossOver交叉
    CrossPop = [];
    ParentIndexes = RWSelect(Cost,CrossNum);
    for ii = 1:CrossNum/2
        Par1Indx = ParentIndexes(ii*2-1);
        Par2Indx = ParentIndexes(ii*2);
        
        Par1 = Pop(Par1Indx,:);
        Par2 = Pop(Par2Indx,:);
        
        [Off1 Off2] = CrossFcn(Par1,Par2);
        CrossPop = [CrossPop ; Off1 ; Off2];
    end
    
    %% Mutation变异
    ParentIndexes = RWSelect(Cost,MutatNum);
    MutatPop=[];
    for ii = 1:MutatNum
        Off3 = MutatFcn(Pop(ParentIndexes(ii),:));
        MutatPop=[MutatPop;Off3];
    end
    %% 提取新种群
    Pop = [ElitPop ; CrossPop ; MutatPop];
    Cost=[];
    for i = 1:size(Pop,1)
        Cost = [Cost;GetCost(Pop(i,:),costList)];
    end
    [Cost Indx] = sort(Cost,'descend');
    Pop = Pop(Indx,:);
    
    %% 数据处理
    BestP = Pop(1,:);
    BestC = Cost(1);
    MinMat(Iter) = Cost(1);
    MeanMat(Iter) = mean(Cost);
    plot(MinMat,'r');
    hold on
end

%% Results
BestSolution = Pop(1,:);
BestCost = Cost(1,:);
[cost,count,team,tsi]=GetCost(BestSolution,costList)
team.list
%% End of Program
toc
mplot

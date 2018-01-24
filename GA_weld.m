
%% Statrt of Program
clear;clc;
close all
tic

%% Algorithm Parameters
SelMethod = 1;
CrossMethod = 1;

PopSize = 1000;
MaxIteration = 50;

CrossPercent = 65;
MutatPercent = 10;
ElitPercent = 100 - CrossPercent - MutatPercent;

CrossNum = round(CrossPercent/100*PopSize); 

if mod(CrossNum,2)~=0;Percent 
    CrossNum = CrossNum - 1; 
end

MutatNum = round(MutatPercent/100*PopSize);
ElitNum = PopSize - CrossNum - MutatNum;

%% Problem Satement

VarMin = [1 2 3 4 5 2];
VarMax =[3 5 5 9 7 3];
b=repmat(VarMin,1000,1);
s=repmat(VarMax,1000,1);
DimNum = 6;
CostFuncName = @rastriginsfcn;

%% Initial Population
Pop = rand(PopSize,DimNum).* (s - b) +b;
Cost = feval(CostFuncName,Pop);
[Cost Indx] = sort(Cost);
Pop = Pop(Indx,:);

%% Main Loop
MeanMat = [];
MinMat = [];

for Iter = 1:MaxIteration
    %% Elitism
    ElitPop = Pop(1:ElitNum,:);
    
    %% Cross Over
    CrossPop = [];
    ParentIndexes = SelectParents_Fcn(Cost,CrossNum,SelMethod);
    
    for ii = 1:CrossNum/2
        Par1Indx = ParentIndexes(ii*2-1);
        Par2Indx = ParentIndexes(ii*2);
        
        Par1 = Pop(Par1Indx,:);
        Par2 = Pop(Par2Indx,:);
        
        [Off1 Off2] = MyCrossOver_Fcn(Par1,Par2,CrossMethod);
        CrossPop = [CrossPop ; Off1 ; Off2];
    end
    
    %% Mutation
    MutatPop = rand(MutatNum,DimNum).*(s(1:100,:) - b(1:100,:)) + b(1:100,:);
        
    %% New Population
    Pop = [ElitPop ; CrossPop ; MutatPop];
    Cost = feval(CostFuncName,Pop);
    [Cost Indx] = sort(Cost);
    Pop = Pop(Indx,:);

    %% Algorithm Progress
    disp('----------------------------------------------')
    BestP = Pop(1,:)
    BestC = Cost(1)
    MinMat(Iter) = Cost(1);
    MeanMat(Iter) = mean(Cost);
    
    plot(MinMat,'--r','linewidth',2);
    hold on
%     plot(MeanMat,'--k','linewidth',2);
%     hold off
    pause(.5)
end
% ylim([0 5])
%% Results
BestSolution = Pop(1,:)
BestCost = Cost(1,:)

%% End of Program
toc

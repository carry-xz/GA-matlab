function [cost,count,team,tsi]= getCost(pop,costList)
count = 1;
count2 = 0;
snum = 0;
team.list=0;
costTime = sum(costList);
tsi=[];list=[];
for i=1:length(pop)
    snum = snum+costList(pop(i));
    if snum>50;
        tsi = [tsi,snum-costList(pop(i))];
        snum = costList(pop(i));
        count2 = i;
        team(count).list=list;
        list = [pop(i)];
        count = count+1;
    else
        list = [list,pop(i)];
    end
end
team(count).list=pop(count2:end);
tsi = [tsi,sum(costList(pop(count2:end)))];
cost = sum((tsi/costTime).^2)/count;
% cost = costTime/count/max(tsi);
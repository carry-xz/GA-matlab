figure()
tn = size(team,2);
y = cell(tn,1);
len0=0;
for ii = 1:1:tn
    y{ii} = team(ii).list;
    len = length(y{ii});
    if len>len0
        len0=len;
    end
end
K=[];
for ii = 1:1:tn
    y{ii}=costList(y{ii});
    y{ii}(len0)=0;
    K(ii,:)=y{ii};
end
bar(K,'stacked');
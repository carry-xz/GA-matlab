function [C1,C2]=CrossFcn(P1,P2)
pos = randi(10,1)+1;
P2s = P2;
for ii = 1:pos
    P2(P2==P1(ii))=[];
    C1=[P1(1:pos),P2(1:length(P2s)-pos)];
end
for ii = 1:pos
    P1(P1==P2s(ii))=[];
    C2=[P2s(1:pos),P1(1:length(P2s)-pos)];
end
end
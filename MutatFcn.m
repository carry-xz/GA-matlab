function C1 = MutatFcn(P1)
global A
pos = randi(12,1);
C1=P1;
if pos==1
    if A(P1(2),P1(1))>-1
        C1(2) = P1(1);
        C1(1) = P1(2);
    else
        MutatFcn(P1);
    end
elseif pos==12
    if A(P1(12),P1(11))>-1
        C1(12) = P1(11);
        C1(11) = P1(12);
    else
        MutatFcn(P1);
    end
else
    if A(P1(pos+1),P1(pos))>-1
        C1(pos+1) = P1(pos);
        C1(pos) = P1(pos+1);
    elseif A(P1(pos),P1(pos-1))>-1
        C1(pos-1) = P1(pos);
        C1(pos) = P1(pos-1);
    end
end
end
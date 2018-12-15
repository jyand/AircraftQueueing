AC = csvread('gooddata1.csv');
nErr = AC(:, 1) - AC(:, 2);
t = AC(:,5);

q = 0;
Q = [];
ncum = 0;
tcum = 0;
for i = 1:length(AC)
    tErr(i) = 15.*i;
    if heaviside(nErr(i))
        ncum = ncum + nErr(i);
        tcum = ncum;
    else
        q = q + 1;
        Q(q) = nErr(i);
    end
    if q
        for j = 1:q
            if ncum >= abs(Q(j))
                ncum = ncum + Q(j);
                q = q - 1;
            else
                tcum = tcum + abs(Q(q));
            end
        end 
    end
    tErr(i) = tErr(i) + 15.*q;
    pErr(i) = 15*tcum;
end

tsaErr = 480.*nErr;
scatter(t, pErr)
hold on
scatter(t, tsaErr)

x1 = tsaErr;
x2 = tErr;

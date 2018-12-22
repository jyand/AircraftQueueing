AC = csvread('gooddata1.csv');
nErr = AC(:, 1) - AC(:, 2);
t = AC(:,5);

q = 0;
Q = [];
ncum = 0;
tcum = 0;
for i = 1:length(AC)
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
    pErr(i) = tcum;
end

tsaErr = abs(nErr);
figure(1)
scatter(t, pErr)
hold on
scatter(t, tsaErr)
hold on
plot(t, 0.4*t + 35, 'g')
legend('passanger cost', 'airline cost', 'linear separator')

figure(2)
scatter(t, pErr)
hold on
f = fit(t, pErr', 'poly2')
plot(f, t, pErr')
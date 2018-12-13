function AC = ACDByear(year)
AC = [];
	for i = 1:12
        switch i
            case 1
                J = 31;
            case 2
                if mod(year, 4) == 0
                    J = 29;
                else
                    J = 28;
                end
            otherwise
               if sqrt(i) == round(sqrt(i)) || mod(i, 5) == 1
                   J = 30;
               else
                   J = 31;
               end
        end
        for j = 1:J
            ac = ACDBday(i, j, year);
            AC = vertcat(AC, ac);
        end
    end
end

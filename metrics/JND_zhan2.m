function MeasureP = JND_zhan2(I)
I = double(I);
[X, Y] = size(I);
Fh = I;
Fv=  I;
J1 = I;
J2 = I;
Ft = 0;
ft = 0;
for x = 4:X-2
    for y = 3:Y-2
        for i = -2:2
            for j = -1:2
                Ft = Ft + (I(x+i,y+j) - I(x+i,y-1+j)).^2;
                ft = ft + (I(x+i,y+j) - I(x+i-1,y+j)).^2;
            end
        end
        Fh(x,y) = Ft./20;
        Fv(x,y) = ft./20;
        Ft = 0;ft = 0;
    end
end
Fs = sqrt(Fh + Fv);
Ia = conv2(I,[1 1 1 1 1;...
              1 2 2 2 1;...
              1 2 0 2 1;...
              1 2 2 2 1;...
              1 1 1 1 1],'same')./32;
dI = abs(I - Ia);
for x = 1:X
    for y = 1:Y
        if I(x,y) < 128
            J1(x,y) = 21 .* (1 - sqrt(Ia(x,y) ./ 127)) + 4;
            J2(x,y) = 0.3 .* Fs(x,y) .* (2 .* (1 - sqrt(Ia(x,y) ./ 127)) + 1);
        else
            J1(x,y) = 3 .* Ia(x,y) ./ 128 + 1;
            J2(x,y) = 0.3 .* Fs(x,y) .* (Ia(x,y) ./ 256 - 12./256 +1 );
        end
    end
end
Jnd = J1 + J2;
[J,~] = edge(I,'canny',0.2,1);
p=double(J);
a=find(p==1);
Measurep = double(dI(a) >= Jnd(a));
MeasureP = sum(Measurep(:)) ./length(a);
end
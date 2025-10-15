function [xOffset, yOffset] = arrLabelOffset(fontSize, nCharsLabelOffset, x, y, tangentOrNormal)

m = (y(2) - y(1)) / (x(2) - x(1));
if (tangentOrNormal == true)
    m = -symInt(1) / m;
end

xOffset = abs(fontSize * nCharsLabelOffset * cos(m));
yOffset = abs(fontSize * nCharsLabelOffset * sin(m));

if (m == symInt(0))
    if (x(2) > x(1))
        yOffset = symInt(0);
        xOffset = fontSize * nCharsLabelOffset;
    else
        yOffset = symInt(0);
        xOffset = -fontSize * nCharsLabelOffset;
    end
end

if (sym(m) == sym(Inf))
    yOffset = fontSize * nCharsLabelOffset;
    xOffset = symInt(0);
end

if (sym(m) == sym(-Inf))
    yOffset = fontSize * nCharsLabelOffset;
    xOffset = symInt(0);
end

end
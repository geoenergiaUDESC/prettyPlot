function [labelPos, pos, exponentPos] = colorbarPositionProperties(p, boxMarginWidth, xAxisWidth, yAxisWidth, cBarOrientation)

offsetFrac = sym(cast(25, 'uint64')) / sym(cast(10000, 'uint64'));

if strcmp(cBarOrientation, "East") == true
    labelPos = [(p.Results.cBarLabelOffset * boxMarginWidth) yAxisWidth / sym(cast(2, 'uint64')) sym(cast(0, 'uint64'))];
    pos = [boxMarginWidth + xAxisWidth + (offsetFrac * p.Results.paperPoints) boxMarginWidth p.Results.cBarWidthScale * p.Results.paperPoints yAxisWidth];
    exponentPos = [xAxisWidth + (boxMarginWidth / sym(cast(4, 'uint64'))) yAxisWidth + (sym(p.Results.fontSize) / sym(cast(1, 'uint64'))) sym(cast(0, 'uint64'))];
else
    labelPos = [xAxisWidth / sym(cast(2, 'uint64')) (p.Results.cBarLabelOffset * boxMarginWidth) sym(cast(0, 'uint64'))];
    pos = [boxMarginWidth boxMarginWidth + yAxisWidth + (offsetFrac * p.Results.paperPoints) xAxisWidth p.Results.cBarWidthScale * p.Results.paperPoints];
    exponentPos = [xAxisWidth + (boxMarginWidth * p.Results.axLabelOffset / sym(cast(2, 'uint64'))) yAxisWidth + (p.Results.cBarWidthScale * p.Results.paperPoints / sym(cast(2, 'uint64'))) + (offsetFrac * p.Results.paperPoints) sym(cast(0, 'uint64'))];
end

end
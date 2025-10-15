function [fig, ax, cbar] = prettyPlot(varargin)

% Check if symbolic toolbox is installed
symToggle = cast(license('test', 'symbolic_toolbox'), 'logical');
if symToggle == true
    integerCastType = 'int64';
    floatCastType = 'sym';
else
    integerCastType = 'int64';
    floatCastType = 'double';
end

% Create parser
p = inputParser;

% Axis parameters
addParameter(p, 'xLim', cast(cast([0 1], integerCastType), floatCastType));
addParameter(p, 'yLim', cast(cast([0 1], integerCastType), floatCastType));
addParameter(p, 'cLim', cast(cast([0 1], integerCastType), floatCastType));
addParameter(p, 'nxTicks', cast(11, 'uint64'));
addParameter(p, 'nyTicks', cast(11, 'uint64'));
addParameter(p, 'ncBarTicks', cast(11, 'uint64'));
addParameter(p, 'usexAxis', true);
addParameter(p, 'useyAxis', true);
addParameter(p, 'useColorBar', false);
addParameter(p, 'useMinorTick', false);
addParameter(p, 'useGrid', false);
addParameter(p, 'useBorder', true);
addParameter(p, 'dataAspectRatio', []);
addParameter(p, 'plotAspectRatio', cast(cast([1 1 1], integerCastType), floatCastType));

% Label parameters
addParameter(p, 'xLabel', "");
addParameter(p, 'yLabel', "");
addParameter(p, 'cBarLabel', "");
addParameter(p, 'title', "");
addParameter(p, 'boxMarginScale', cast(cast(9, integerCastType), floatCastType) / cast(cast(100, integerCastType), floatCastType));
addParameter(p, 'axLabelOffset', cast(cast(3, integerCastType), floatCastType) / cast(cast(4, integerCastType), floatCastType));
addParameter(p, 'cBarLabelOffset', cast(cast(3, integerCastType), floatCastType) / cast(cast(4, integerCastType), floatCastType));
addParameter(p, 'cBarWidthScale', cast(cast(1, integerCastType), floatCastType) / cast(cast(100, integerCastType), floatCastType));
addParameter(p, 'xTickFormat', cast(5, 'uint64'));
addParameter(p, 'yTickFormat', cast(5, 'uint64'));
addParameter(p, 'xLabelAngle', cast(cast(0, integerCastType), floatCastType));
addParameter(p, 'yLabelAngle', cast(cast(90, integerCastType), floatCastType));
addParameter(p, 'cBarLabelAngle', cast(cast(90, integerCastType), floatCastType));
addParameter(p, 'cBarTickFormat', cast(5, 'uint64'));
addParameter(p, 'xAxisScale', 'Linear');
addParameter(p, 'yAxisScale', 'Linear');
addParameter(p, 'xScientificNotation', false);
addParameter(p, 'yScientificNotation', false);
addParameter(p, 'cBarScientificNotation', false);
addParameter(p, 'xTickFractions', false);
addParameter(p, 'yTickFractions', false);
addParameter(p, 'cBarTickFractions', false);
addParameter(p, 'xTickLabels', []);
addParameter(p, 'yTickLabels', []);
addParameter(p, 'cBarTickLabels', []);

% Colour bar parameters
addParameter(p, 'colorMap', parula(cast(2 .^ 14, 'uint64')));
addParameter(p, 'cBarLocation', 'East');
addParameter(p, 'cBarTickLabelAngle', []);

% Font parameters
addParameter(p, 'fontName', 'Times');
addParameter(p, 'fontUnits', 'points');
addParameter(p, 'fontSize', cast(cast(10, integerCastType), floatCastType));
addParameter(p, 'labelInterpreter', "latex");

% Paper parameters
addParameter(p, 'textWidth', cast(cast(1, integerCastType), floatCastType));
addParameter(p, 'paperPoints', cast(cast(595, integerCastType), floatCastType));
addParameter(p, 'marginPoints', cast(cast(90, integerCastType), floatCastType));

% Parse the input
parse(p, varargin{:});

% Get the axis scale - log or linear
xLogScale = string(p.Results.xAxisScale) == "log";
yLogScale = string(p.Results.yAxisScale) == "log";

% Some style variables
white = cast(cast([1 1 1], 'uint64'), 'double');
black = cast(cast([0 0 0], 'uint64'), 'double');
alphaMap = cast(linspace(cast(cast(0, 'uint64'), floatCastType), cast(cast(1, 'uint64'), floatCastType), 1001), 'double');
one = cast(1, 'uint64');
lineWidth = cast(cast(cast(1, 'uint64'), floatCastType) / cast(cast(2, 'uint64'), floatCastType), 'double');

% Parse the inputs
if isempty(p.Results.dataAspectRatio)
    dataAspectRatioToggle = false;
else
    dataAspectRatioToggle = true;
end
LaTeXToggle = strcmp(p.Results.labelInterpreter, "latex");

% Create ticks and labels
xTickLabels = p.Results.xTickLabels;
if isempty(xTickLabels)
    [xTicks, xTickLabels, xExponentLabel] = createTicksAndLabels( ...
        p.Results.xLim(1), ...
        p.Results.xLim(2), ...
        p.Results.nxTicks, ...
        p.Results.xTickFormat, ...
        LaTeXToggle, ...
        p.Results.xTickFractions, ...
        p.Results.xScientificNotation, xLogScale);
else
    [xTicks, ~, xExponentLabel] = createTicksAndLabels( ...
        p.Results.xLim(1), ...
        p.Results.xLim(2), ...
        length(p.Results.xTickLabels), ...
        p.Results.xTickFormat, ...
        LaTeXToggle, ...
        p.Results.xTickFractions, ...
        p.Results.xScientificNotation, xLogScale);
end
yTickLabels = p.Results.yTickLabels;
if isempty(yTickLabels)
    [yTicks, yTickLabels, yExponentLabel] = createTicksAndLabels( ...
        p.Results.yLim(1), ...
        p.Results.yLim(2), ...
        p.Results.nyTicks, ...
        p.Results.yTickFormat, ...
        LaTeXToggle, ...
        p.Results.yTickFractions, ...
        p.Results.yScientificNotation, yLogScale);
else
    [yTicks, ~, yExponentLabel] = createTicksAndLabels( ...
        p.Results.yLim(1), ...
        p.Results.yLim(2), ...
        length(p.Results.yTickLabels), ...
        p.Results.yTickFormat, ...
        LaTeXToggle, ...
        p.Results.yTickFractions, ...
        p.Results.yScientificNotation, yLogScale);
end
cBarTickLabels = p.Results.cBarTickLabels;
if isempty(p.Results.cBarTickLabels)
    [cBarTicks, cBarTickLabels, cBarExponentLabel] = createTicksAndLabels( ...
        p.Results.cLim(1), ...
        p.Results.cLim(2), ...
        p.Results.ncBarTicks, ...
        p.Results.cBarTickFormat, ...
        LaTeXToggle, ...
        p.Results.cBarTickFractions, ...
        p.Results.cBarScientificNotation, false);
else
    [cBarTicks, ~, cBarExponentLabel] = createTicksAndLabels( ...
        p.Results.cLim(1), ...
        p.Results.cLim(2), ...
        length(p.Results.cBarTickLabels), ...
        p.Results.cBarTickFormat, ...
        LaTeXToggle, ...
        p.Results.cBarTickFractions, ...
        p.Results.cBarScientificNotation, false);
end

if dataAspectRatioToggle == true
    boxAspectRatio = (xTicks(end) - xTicks(1)) / (yTicks(end) - yTicks(1));
else
    boxAspectRatio = p.Results.plotAspectRatio(1) / p.Results.plotAspectRatio(2);
end

% Set the width of the paper
xFigWidth = (p.Results.paperPoints - (cast(cast(2, 'uint64'), floatCastType) * p.Results.marginPoints)) * p.Results.textWidth;
boxMarginWidth = (p.Results.boxMarginScale * xFigWidth) / p.Results.textWidth;
xAxisWidth = xFigWidth - (cast(cast(2, 'uint64'), floatCastType) * boxMarginWidth);
yAxisWidth = xAxisWidth / boxAspectRatio;
yFigWidth = yAxisWidth + (cast(cast(2, 'uint64'), floatCastType) * boxMarginWidth);
x0 = cast(cast(0, 'uint64'), floatCastType);
y0 = x0;

% Set the position of the title and the axis labels
titlePosition = [xAxisWidth / cast(cast(2, 'uint64'), floatCastType) yAxisWidth + (boxMarginWidth / sym(cast(2, 'uint64'))) sym(cast(0, 'uint64'))];
xLabelPosition = [xAxisWidth / cast(cast(2, 'uint64'), floatCastType) -boxMarginWidth * p.Results.axLabelOffset cast(cast(0, 'uint64'), floatCastType)];
yLabelPosition = [-boxMarginWidth * p.Results.axLabelOffset yAxisWidth / cast(cast(2, 'uint64'), floatCastType) cast(cast(2, 'uint64'), floatCastType)];
xExponentPosition = [xAxisWidth -cast(cast(2, 'uint64'), floatCastType) * sym(p.Results.fontSize) cast(cast(0, 'uint64'), floatCastType)];
yExponentPosition = [sym(p.Results.fontSize) / cast(cast(2, 'uint64'), floatCastType) yAxisWidth + (sym(p.Results.fontSize) / cast(cast(1, 'uint64'), floatCastType)) cast(cast(0, 'uint64'), floatCastType)];

% Set the position of the colour bar
[cBarLabelPosition, cBarPosition, cBarExponentPosition] = colorbarPositionProperties(p, boxMarginWidth, xAxisWidth, yAxisWidth, p.Results.cBarLocation);

% Create the figure and axis
fig = figure;
ax = gca;
axis on;
hold on;

% Set the figure position
fig.Units = 'Points';
fig.Position = cast([x0 y0 xFigWidth yFigWidth], 'double');
fig.InnerPosition = fig.Position;
fig.Renderer = 'painters';

% Set the figure style
fig.Alphamap = alphaMap;
fig.PaperUnits = 'points';
fig.Color = white;

% Set the axis style
ax.Units = 'points';
ax.PositionConstraint = 'innerposition';
if p.Results.useBorder == true
    ax.Box = 'on';
else
    ax.Box = 'off';
end
ax.BoxStyle = 'back';
ax.Color = white;
if dataAspectRatioToggle == true
    ax.DataAspectRatio = cast(p.Results.dataAspectRatio, 'double');
end
ax.FontName = p.Results.fontName;
ax.FontSize = cast(p.Results.fontSize, 'double');
ax.FontUnits = 'points';
ax.FontWeight = 'normal';
ax.GridColor = black;
ax.LabelFontSizeMultiplier = 1;
ax.LineWidth = lineWidth;
ax.MinorGridColor = black;
if dataAspectRatioToggle == false
    ax.PlotBoxAspectRatio = cast(p.Results.plotAspectRatio, 'double');
end
ax.Position = cast([boxMarginWidth boxMarginWidth xAxisWidth yAxisWidth], 'double');
ax.TickLabelInterpreter = p.Results.labelInterpreter;
ax.TitleFontWeight = 'normal';
ax.View = [0 90];

% Create colorbar and color map
ax.Colormap = p.Results.colorMap;
cbar = colorbar;
cbar.Location = p.Results.cBarLocation;
cbar.AxisLocationMode = 'manual';
cbar.Units = 'points';
cbar.Color = black;
cbar.FontName = p.Results.fontName;
cbar.FontSize = cast(p.Results.fontSize, 'double');
cbar.Label.Units = 'points';
cbar.Label.Color = black;
cbar.Label.FontName = p.Results.fontName;
cbar.Label.FontSize = cast(p.Results.fontSize, 'double');
cbar.Label.FontUnits = 'points';
cbar.Label.HorizontalAlignment = 'Center';
cbar.Label.Interpreter = p.Results.labelInterpreter;
cbar.Label.Position = cast(cBarLabelPosition, 'double');
cbar.Label.Rotation = cast(p.Results.cBarLabelAngle, 'double');
cbar.Label.String = p.Results.cBarLabel;
cbar.Label.LineWidth = lineWidth;
cbar.Label.VerticalAlignment = 'middle';
cbar.Limits = cast(p.Results.cLim, 'double');
cbar.LineWidth = lineWidth;
cbar.Position = cast(cBarPosition, 'double');
cbar.TickLabelInterpreter = p.Results.labelInterpreter;
cbar.TickLabels = cBarTickLabels;
cbar.Ticks = cast(cBarTicks, 'double');
cbar.Visible = 'on';
if not(isempty(p.Results.cBarTickLabelAngle))
    cbar.Ruler.TickLabelRotationMode = 'Manual';
    cbar.Ruler.TickLabelRotation = p.Results.cBarTickLabelAngle;
else
    cbar.Ruler.TickLabelRotationMode = 'Auto';
end
if p.Results.useColorBar == true
    cbar.Visible = 'on';
else
    cbar.Visible = 'off';
end

% Set the axis font
ax.FontUnits = 'points';
ax.FontName = p.Results.fontName;
ax.FontSize = cast(p.Results.fontSize, 'double');
ax.FontWeight = 'normal';

% Set the title and axis labels
ax.Title = setLabel(p.Results.title, ...
    p.Results.fontName, ...
    p.Results.fontSize, ...
    titlePosition, ...
    p.Results.labelInterpreter, ...
    ax.Title, 0);
ax.XLabel = setLabel(p.Results.xLabel, ...
    p.Results.fontName, ...
    p.Results.fontSize, ...
    xLabelPosition, ...
    p.Results.labelInterpreter, ...
    ax.XLabel, ...
    p.Results.xLabelAngle);
ax.YLabel = setLabel(p.Results.yLabel, ...
    p.Results.fontName, ...
    p.Results.fontSize, ...
    yLabelPosition, ...
    p.Results.labelInterpreter, ...
    ax.YLabel, ...
    p.Results.yLabelAngle);

% Set the axes
setAxis([xTicks(1) xTicks(end)], ...
    p.Results.xLabel, ...
    xTicks, ...
    xTickLabels, ...
    p.Results.fontName, ...
    p.Results.fontSize, ...
    xLabelPosition, ...
    p.Results.labelInterpreter, ...
    p.Results.useMinorTick, ...
    p.Results.xAxisScale, ...
    ax.XAxis);
setAxis([yTicks(1) yTicks(end)], ...
    p.Results.yLabel, ...
    yTicks, ...
    yTickLabels, ...
    p.Results.fontName, ...
    p.Results.fontSize, ...
    yLabelPosition, ...
    p.Results.labelInterpreter, ...
    p.Results.useMinorTick, ...
    p.Results.yAxisScale, ...
    ax.YAxis);

% Set the rest of the parameters
if p.Results.useGrid == true
    ax.XGrid = 'on';
    ax.YGrid = 'on';
else
    ax.XGrid = 'off';
    ax.YGrid = 'off';
end
ax.XColor = black;
ax.YColor = black;
if p.Results.usexAxis == true
    ax.XAxis.Visible = 'on';
else
    ax.XAxis.Visible = 'off';
end
if p.Results.useyAxis == true
    ax.YAxis.Visible = 'on';
else
    ax.YAxis.Visible = 'off';
end

% Set the axis limits
ax.XLim = cast(p.Results.xLim, 'double');
ax.YLim = cast(p.Results.yLim, 'double');
ax.CLim = cast(p.Results.cLim, 'double');

% Create border
if p.Results.useBorder == true
    line([p.Results.xLim(1) p.Results.xLim(2) p.Results.xLim(2) p.Results.xLim(1) p.Results.xLim(1)], ...
        [p.Results.yLim(1) p.Results.yLim(1) p.Results.yLim(2) p.Results.yLim(2) p.Results.yLim(1)], ...
        [1 1 1 1 1], ...
        'Color', black, ...
        'HandleVisibility', 'off', ...
        'LineStyle', '-', ...
        'LineWidth', lineWidth);
end

% Write the exponent labels
if p.Results.xScientificNotation == true
    writeExponentLabel(xExponentLabel, ...
        p.Results.fontName, ...
        p.Results.fontSize, ...
        p.Results.labelInterpreter, ...
        lineWidth, ...
        xExponentPosition);
end
if p.Results.yScientificNotation == true
    writeExponentLabel(yExponentLabel, ...
        p.Results.fontName, ...
        p.Results.fontSize, ...
        p.Results.labelInterpreter, ...
        lineWidth, ...
        yExponentPosition);
end
if p.Results.cBarScientificNotation == true
    writeExponentLabel(cBarExponentLabel, ...
        p.Results.fontName, ...
        p.Results.fontSize, ...
        p.Results.labelInterpreter, ...
        lineWidth, ...
        cBarExponentPosition);
end

% Reset the color index to origin
ax.ColorOrderIndex = one;

    function writeExponentLabel(exponentLabel, fontName, fontSize, labelInterpreter, lineWidth, exponentPosition)

        black = cast([cast(0, 'uint64') cast(0, 'uint64') cast(0, 'uint64')], 'double');

        exponentText = text(0, 0, exponentLabel);
        exponentText.Units = 'points';
        exponentText.BackgroundColor = 'none';
        exponentText.Color = black;
        exponentText.FontName = fontName;
        exponentText.FontSize = cast(fontSize, 'double');
        exponentText.FontUnits = 'points';
        exponentText.HandleVisibility = 'off';
        exponentText.HorizontalAlignment = 'center';
        exponentText.Interpreter = labelInterpreter;
        exponentText.LineStyle = '-';
        exponentText.LineWidth = lineWidth;
        exponentText.Position = cast(exponentPosition, 'double');
        exponentText.String = exponentLabel;
        exponentText.VerticalAlignment = 'middle';

    end

    function label = setLabel(labelString, fontName, fontSize, labelPosition, labelInterpreter, label, angle)

        black = cast([cast(0, 'uint64') cast(0, 'uint64') cast(0, 'uint64')], 'double');

        label.Units = 'points';
        label.FontUnits = 'points';

        label.BackgroundColor = 'None';
        label.Color = black;
        label.FontName = fontName;
        label.FontSize = cast(fontSize, 'double');
        label.FontWeight = 'normal';
        label.HandleVisibility = 'off';
        label.HorizontalAlignment = 'center';
        label.Interpreter = labelInterpreter;
        label.LineWidth = cast(sym(cast(1, 'uint64')) / sym(cast(2, 'uint64')), 'double');
        label.Position = cast(labelPosition, 'double');
        label.String = labelString;
        label.VerticalAlignment = 'middle';
        label.Visible = 'on';
        label.Rotation = cast(angle, 'double');

    end

    function setAxis(axisLimits, labelString, tickValues, tickLabels, fontName, fontSize, labelPosition, labelInterpreter, useMinorTick, axisScale, axis)

        black = cast([cast(0, 'uint64') cast(0, 'uint64') cast(0, 'uint64')], 'double');

        % Set the x axis
        axis.Color = black;
        axis.FontName = fontName;
        axis.FontSize = cast(fontSize, 'double');
        axis.FontWeight = 'normal';
        axis.HandleVisibility = 'off';
        axis.Label.Color = black;
        axis.Label.FontName = fontName;
        axis.Label.FontSize = cast(fontSize, 'double');
        axis.Label.FontUnits = 'points';
        axis.Label.FontWeight = 'normal';
        axis.Label.HandleVisibility = 'off';
        axis.Label.HorizontalAlignment = 'center';
        axis.Label.Interpreter = labelInterpreter;
        axis.Label.LineWidth = cast(sym(cast(1, 'uint64')) / sym(cast(2, 'uint64')), 'double');
        axis.Label.Units = 'points';
        axis.Label.Position = cast(labelPosition, 'double');
        axis.Label.String = labelString;
        axis.Label.VerticalAlignment = 'middle';
        axis.Label.Visible = 'on';
        axis.Limits = cast(axisLimits, 'double');
        axis.LineWidth = cast(sym(cast(1, 'uint64')) / sym(cast(2, 'uint64')), 'double');
        if useMinorTick == true
            axis.MinorTick = 'on';
        else
            axis.MinorTick = 'off';
        end
        axis.Scale = axisScale;
        axis.TickLabelInterpreter = labelInterpreter;
        axis.TickLabels = tickLabels;
        axis.TickValues = cast(tickValues, 'double');

    end

end
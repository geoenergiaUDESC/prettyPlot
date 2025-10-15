function prettySurf(varargin)

% Check if symbolic toolbox is installed
symtoggle = license('test', 'symbolic_toolbox');

% Get information on screen size
set(0, 'Units', 'Points');
ResPoints = get(0, 'Screensize');
if symtoggle == true
    ResPoints = simplify(sym(ResPoints), 'Steps', 100);
else
end

% Create parser
p = inputParser;

% Interpreter parameters
addParameter(p, 'Interpreter', 'latex');

% Font parameters
addParameter(p, 'FontName', 'Times');
addParameter(p, 'FontSize', 10);
addParameter(p, 'TitleFontWeight', 'bold');
addParameter(p, 'LabelFontWeight', 'normal');
addParameter(p, 'AxisFontWeight', 'normal');

% Plot box parameters
addParameter(p, 'AxLabelOffset', 0.25);
addParameter(p, 'CBarWidthScale', 0.02);
addParameter(p, 'CBarLabelOffset', 0.75);
addParameter(p, 'BoxMarginScale', 0.1);
addParameter(p, 'DataAspectRatio', []);
addParameter(p, 'PaperMarginPoints', 90);
addParameter(p, 'PaperPoints', 595);
addParameter(p, 'PlotAspectRatio', [1 1 1]);
addParameter(p, 'TextWidthScale', 1);

% Axes parameters
addParameter(p, 'AlphaAxis', [0 1]);
addParameter(p, 'CAxis', [-5 5]);
addParameter(p, 'NCBarTicks', 11);
addParameter(p, 'NXTicks', 5);
addParameter(p, 'NYTicks', 5);
addParameter(p, 'NZTicks', 5);
addParameter(p, 'UseColorBar', false);
addParameter(p, 'UseCBarTickFractions', false);
addParameter(p, 'UseCBarScientificNotation', false);
addParameter(p, 'UseXAxis', true);
addParameter(p, 'UseXTickFractions', false);
addParameter(p, 'UseXScientificNotation', false);
addParameter(p, 'UseYAxis', true);
addParameter(p, 'UseYTickFractions', false);
addParameter(p, 'UseYScientificNotation', false);
addParameter(p, 'UseZAxis', true);
addParameter(p, 'UseZTickFractions', false);
addParameter(p, 'UseZScientificNotation', false);
addParameter(p, 'XLim', [-5 5]);
addParameter(p, 'YLim', [-5 5]);
addParameter(p, 'ZLim', [-5 5]);
addParameter(p, 'XTicks', []);
addParameter(p, 'YTicks', []);
addParameter(p, 'ZTicks', []);
addParameter(p, 'CBarTicks', []);

% Label parameters
addParameter(p, 'CBarLabel', strings(1));
addParameter(p, 'CBarTickFormat', 5);
addParameter(p, 'Title', strings(1));
addParameter(p, 'XLabel', strings(1));
addParameter(p, 'YLabel', strings(1));
addParameter(p, 'ZLabel', strings(1));
addParameter(p, 'XTickFormat', 5);
addParameter(p, 'YTickFormat', 5);
addParameter(p, 'ZTickFormat', 5);

% Aesthetic parameters
addParameter(p, 'LineWidth', 0.5);
addParameter(p, 'UseBorder', true);
addParameter(p, 'UseGrid', false);
addParameter(p, 'UseMinorTick', false);
addParameter(p, 'ViewAngle', [37.5 30]);

% Parse
parse(p, varargin{:});

% Parsed interpreter parameters
Interpreter = p.Results.Interpreter;

% Parsed font parameters
FontName = p.Results.FontName;
FontSize = p.Results.FontSize;
TitleFontWeight = p.Results.TitleFontWeight;
LabelFontWeight = p.Results.LabelFontWeight;
AxisFontWeight = p.Results.AxisFontWeight;

% Parsed plot box parameters
AxLabelOffset = p.Results.AxLabelOffset;
BoxMarginScale = p.Results.BoxMarginScale;
CBarWidthScale = p.Results.CBarWidthScale;
CBarLabelOffset = p.Results.CBarLabelOffset;
%DataAspectRatio = p.Results.DataAspectRatio;
PaperMarginPoints = p.Results.PaperMarginPoints;
PaperPoints = p.Results.PaperPoints;
TextWidthScale = p.Results.TextWidthScale;
%PlotAspectRatio = p.Results.PlotAspectRatio;

% Parsed axes parameters
AlphaMax = p.Results.AlphaAxis(2);
AlphaMin = p.Results.AlphaAxis(1);
CBarMax = p.Results.CAxis(2);
CBarMin = p.Results.CAxis(1);
NCBarTicks = p.Results.NCBarTicks;
NXTicks = p.Results.NXTicks;
NYTicks = p.Results.NYTicks;
NZTicks = p.Results.NZTicks;
UseColorBar = p.Results.UseColorBar;
UseCBarTickFractions = p.Results.UseCBarTickFractions;
UseCBarScientificNotation = p.Results.UseCBarScientificNotation;
UseXAxis = p.Results.UseXAxis;
UseXTickFractions = p.Results.UseXTickFractions;
UseXScientificNotation = p.Results.UseXScientificNotation;
UseYAxis = p.Results.UseYAxis;
UseYTickFractions = p.Results.UseYTickFractions;
UseYScientificNotation = p.Results.UseYScientificNotation;
UseZAxis = p.Results.UseZAxis;
UseZTickFractions = p.Results.UseZTickFractions;
UseZScientificNotation = p.Results.UseZScientificNotation;
XMax = p.Results.XLim(2);
XMin = p.Results.XLim(1);
YMax = p.Results.YLim(2);
YMin = p.Results.YLim(1);
ZMax = p.Results.ZLim(2);
ZMin = p.Results.ZLim(1);
XTicks = p.Results.XTicks;
YTicks = p.Results.YTicks;
ZTicks = p.Results.ZTicks;
CBarTicks = p.Results.CBarTicks;

% Parsed label parameters
CBarLabelString = p.Results.CBarLabel;
CBarTickFormat = p.Results.CBarTickFormat;
TitleString = p.Results.Title;
XTickFormat = p.Results.XTickFormat;
XLabelString = p.Results.XLabel;
YTickFormat = p.Results.YTickFormat;
YLabelString = p.Results.YLabel;
ZTickFormat = p.Results.ZTickFormat;
ZLabelString = p.Results.ZLabel;

% Parsed aesthetic parameters
LineWidth = p.Results.LineWidth;
UseBorder = p.Results.UseBorder;
UseGrid = p.Results.UseGrid;
UseMinorTick = p.Results.UseMinorTick;
ViewAngle = p.Results.ViewAngle;

% Set figure and axis dimensions
if symtoggle == 1
    TextWidthScale = simplify(sym(TextWidthScale), 'Steps', 100);
    AxLabelOffset = simplify(sym(AxLabelOffset), 'Steps', 100);
    CBarWidthScale = simplify(sym(CBarWidthScale), 'Steps', 100);
    CBarLabelOffset = simplify(sym(CBarLabelOffset), 'Steps', 100);
    BoxMarginScale = simplify(sym(BoxMarginScale), 'Steps', 100);
    %DataAspectRatio = simplify(sym(DataAspectRatio), 'Steps', 100);
    PaperMarginPoints = simplify(sym(PaperMarginPoints), 'Steps', 100);
    PaperPoints = simplify(sym(PaperPoints), 'Steps', 100);
    %PlotAspectRatio = simplify(sym(PlotAspectRatio), 'Steps', 100);
    CBarMax = simplify(sym(CBarMax), 'Steps', 100);
    CBarMin = simplify(sym(CBarMin), 'Steps', 100);
    NCBarTicks = simplify(sym(NCBarTicks), 'Steps', 100);
    NXTicks = simplify(sym(NXTicks), 'Steps', 100);
    NYTicks = simplify(sym(NYTicks), 'Steps', 100);
    NZTicks = simplify(sym(NZTicks), 'Steps', 100);
    XMax = simplify(sym(XMax), 'Steps', 100);
    XMin = simplify(sym(XMin), 'Steps', 100);
    YMax = simplify(sym(YMax), 'Steps', 100);
    YMin = simplify(sym(YMin), 'Steps', 100);
    ZMax = simplify(sym(ZMax), 'Steps', 100);
    ZMin = simplify(sym(ZMin), 'Steps', 100);
    ViewAngle = simplify(sym(ViewAngle), 'Steps', 100);
    AzViewAngle = simplify(ViewAngle(1), 'Steps', 100);
    ElViewAngle = simplify(ViewAngle(2), 'Steps', 100);
    XRange = simplify(XMax-XMin, 'Steps', 100);
    YRange = simplify(YMax-YMin, 'Steps', 100);
    XMid = simplify((XMax + XMin) / sym(2), 'Steps', 100);
    YMid = simplify((YMax + YMin) / sym(2), 'Steps', 100);
    ZMid = simplify((ZMax + ZMin) / sym(2), 'Steps', 100);
    if AzViewAngle >= sym(360)
        AzViewAngle = simplify(AzViewAngle - ((ceil((AzViewAngle - sym(360)) / sym(360))) * sym(360)), 'Steps', 100);
    end
    if AzViewAngle < sym(0)
        AzViewAngle = simplify(AzViewAngle + ((ceil((-AzViewAngle) / sym(360))) * sym(360)), 'Steps', 100);
    end
    if ElViewAngle >= sym(360)
        ElViewAngle = simplify(ElViewAngle - ((ceil((ElViewAngle - sym(360)) / sym(360))) * sym(360)), 'Steps', 100);
    end
    if ElViewAngle < sym(0)
        ElViewAngle = simplify(ElViewAngle + ((ceil((-ElViewAngle) / sym(360))) * sym(360)), 'Steps', 100);
    end
    ViewAngle(1) = simplify(AzViewAngle, 'Steps', 100);
    ViewAngle(2) = simplify(ElViewAngle, 'Steps', 100);
    XFigWidth = simplify((PaperPoints - (sym(2) * PaperMarginPoints)) * TextWidthScale, 'Steps', 100);
    BoxMarginWidth = simplify((BoxMarginScale * XFigWidth) / TextWidthScale, 'Steps', 100);
    XAxisWidth = simplify(XFigWidth - (sym(2) * BoxMarginWidth), 'Steps', 100);
    YAxisWidth = simplify(XAxisWidth / sym(1), 'Steps', 100);
    YFigWidth = simplify(YAxisWidth + (sym(2) * BoxMarginWidth), 'Steps', 100);
    FigInnerPosition = simplify([BoxMarginWidth BoxMarginWidth XAxisWidth YAxisWidth], 'Steps', 100);
    AxisPosition = simplify([BoxMarginWidth BoxMarginWidth XAxisWidth YAxisWidth], 'Steps', 100);
    TitlePosition = simplify([XAxisWidth / sym(2) YAxisWidth + (sym(0.5) * BoxMarginWidth) sym(0)], 'Steps', 100);
    CBarPosition = simplify([BoxMarginWidth + XAxisWidth + (sym(0.0025) * PaperPoints) BoxMarginWidth CBarWidthScale * PaperPoints YAxisWidth], 'Steps', 100);
    CBarLabelPosition = simplify([CBarLabelOffset * BoxMarginWidth XAxisWidth / sym(2) sym(0)], 'Steps', 100);
    if ViewAngle(1) >= sym(0) && ViewAngle(1) < sym(90)
        XLabelPosition = simplify([XMid YMin - (YRange * AxLabelOffset) ZMin], 'Steps', 100);
        YLabelPosition = simplify([XMax + (XRange * AxLabelOffset) YMid ZMin], 'Steps', 100);
        ZLabelPosition = simplify([XMin - (XRange * AxLabelOffset) YMin ZMid], 'Steps', 100);
        XExponentPosition = simplify([XMin YMin - (AxLabelOffset * YRange) ZMin], 'Steps', 100);
        YExponentPosition = simplify([XMax + (AxLabelOffset * XRange) YMin ZMin], 'Steps', 100);
        ZExponentPosition = simplify([XMin - (XRange * AxLabelOffset) YMin ZMax], 'Steps', 100);
    else
    end
    if ViewAngle(1) >= sym(90) && ViewAngle(1) < sym(180)
        XLabelPosition = simplify([XMid YMax + (YRange * AxLabelOffset) ZMin], 'Steps', 100);
        YLabelPosition = simplify([XMax + (XRange * AxLabelOffset) YMid ZMin], 'Steps', 100);
        ZLabelPosition = simplify([XMax YMin - (YRange * AxLabelOffset) ZMid], 'Steps', 100);
        XExponentPosition = simplify([XMax YMax + (AxLabelOffset * YRange) ZMin], 'Steps', 100);
        YExponentPosition = simplify([XMax + (AxLabelOffset * XRange) YMin ZMin], 'Steps', 100);
        ZExponentPosition = simplify([XMax YMin - (AxLabelOffset * YRange) ZMax], 'Steps', 100);
    else
    end
    if ViewAngle(1) >= sym(180) && ViewAngle(1) < sym(270)
        XLabelPosition = simplify([XMid YMax + (YRange * AxLabelOffset) ZMin], 'Steps', 100);
        YLabelPosition = simplify([XMin - (XRange * AxLabelOffset) YMid ZMin], 'Steps', 100);
        ZLabelPosition = simplify([XMax + (XRange * AxLabelOffset) YMax ZMid], 'Steps', 100);
        XExponentPosition = simplify([XMax YMax + (AxLabelOffset * YRange) ZMin], 'Steps', 100);
        YExponentPosition = simplify([XMin - (AxLabelOffset * XRange) YMax ZMin], 'Steps', 100);
        ZExponentPosition = simplify([XMax + (XRange * AxLabelOffset) YMax ZMax], 'Steps', 100);
    else
    end
    if ViewAngle(1) >= sym(270) && ViewAngle(1) < sym(360)
        XLabelPosition = simplify([XMid YMin - (YRange * AxLabelOffset) ZMin], 'Steps', 100);
        YLabelPosition = simplify([XMin - (XRange * AxLabelOffset) YMid ZMin], 'Steps', 100);
        ZLabelPosition = simplify([XMin YMax + (YRange * AxLabelOffset) ZMid], 'Steps', 100);
        XExponentPosition = simplify([XMin YMin - (AxLabelOffset * YRange) ZMin], 'Steps', 100);
        YExponentPosition = simplify([XMin - (AxLabelOffset * XRange) YMax ZMin], 'Steps', 100);
        ZExponentPosition = simplify([XMin YMax + (AxLabelOffset * YRange) ZMax], 'Steps', 100);
    else
    end
    FigXOrigin = simplify((ResPoints(3) / sym(2)) - (XFigWidth / sym(2)), 'Steps', 100);
    FigYOrigin = simplify((ResPoints(4) / sym(2)) - (YFigWidth / sym(2)), 'Steps', 100);
    FigPosition = simplify([FigXOrigin FigYOrigin XFigWidth YFigWidth], 'Steps', 100);
    CBarExponentXYZ = simplify([XAxisWidth + (sym(0.25) * BoxMarginWidth) YAxisWidth + (sym(0.5) * FontSize) sym(0)], 'Steps', 100);
else
    XRange = XMax - XMin;
    YRange = YMax - YMin;
    XMid = (XMax + XMin) / 2;
    YMid = (YMax + YMin) / 2;
    ZMid = (ZMax + ZMin) / 2;
    AzViewAngle = ViewAngle(1);
    ElViewAngle = ViewAngle(2);
    if AzViewAngle >= 360
        AzViewAngle = AzViewAngle - ((ceil((AzViewAngle - 360) / 360)) * 360);
    end
    if AzViewAngle < 0
        AzViewAngle = AzViewAngle + ((ceil((-AzViewAngle) / 360)) * 360);
    end
    if ElViewAngle >= 360
        ElViewAngle = ElViewAngle - ((ceil((ElViewAngle - 360) / 360)) * 360);
    end
    if ElViewAngle < 0
        ElViewAngle = ElViewAngle + ((ceil((-ElViewAngle) / 360)) * 360);
    end
    ViewAngle(1) = AzViewAngle;
    ViewAngle(2) = ElViewAngle;
    XFigWidth = PaperPoints - (2 * PaperMarginPoints);
    BoxMarginWidth = BoxMarginScale * XFigWidth;
    XAxisWidth = XFigWidth - (2 * BoxMarginWidth);
    YAxisWidth = XAxisWidth * ((YMax - YMin) / (XMax - XMin));
    YFigWidth = YAxisWidth + (2 * BoxMarginWidth);
    FigInnerPosition = [BoxMarginWidth BoxMarginWidth XAxisWidth YAxisWidth];
    AxisPosition = [BoxMarginWidth BoxMarginWidth XAxisWidth YAxisWidth];
    TitlePosition = [XAxisWidth / 2 YAxisWidth + (0.5 * BoxMarginWidth) 0];
    CBarPosition = [BoxMarginWidth + XAxisWidth + (0.025 * PaperPoints) BoxMarginWidth CBarWidthScale * PaperPoints YAxisWidth];
    CBarLabelPosition = [AxLabelOffset * BoxMarginWidth XAxisWidth / 2 0];
    if ViewAngle(1) >= 0 && ViewAngle(1) < 90
        XLabelPosition = [XMid YMin - (YRange * AxLabelOffset) ZMin];
        YLabelPosition = [XMax + (XRange * AxLabelOffset) YMid ZMin];
        ZLabelPosition = [XMin - (XRange * AxLabelOffset) YMin ZMid];
        XExponentPosition = [XMin YMin - (AxLabelOffset * YRange) ZMin];
        YExponentPosition = [XMax + (AxLabelOffset * XRange) YMin ZMin];
        ZExponentPosition = [XMin - (XRange * AxLabelOffset) YMin ZMax];
    else
    end
    if ViewAngle(1) >= 90 && ViewAngle(1) < 180
        XLabelPosition = [XMid YMax + (YRange * AxLabelOffset) ZMin];
        YLabelPosition = [XMax + (XRange * AxLabelOffset) YMid ZMin];
        ZLabelPosition = [XMax YMin - (YRange * AxLabelOffset) ZMid];
        XExponentPosition = [XMax YMax + (AxLabelOffset * YRange) ZMin];
        YExponentPosition = [XMax + (AxLabelOffset * XRange) YMin ZMin];
        ZExponentPosition = [XMax YMin - (AxLabelOffset * YRange) ZMax];
    else
    end
    if ViewAngle(1) >= 180 && ViewAngle(1) < 270
        XLabelPosition = [XMid YMax + (YRange * AxLabelOffset) ZMin];
        YLabelPosition = [XMin - (XRange * AxLabelOffset) YMid ZMin];
        ZLabelPosition = [XMax + (XRange * AxLabelOffset) YMax ZMid];
        XExponentPosition = [XMax YMax + (AxLabelOffset * YRange) ZMin];
        YExponentPosition = [XMin - (AxLabelOffset * XRange) YMax ZMin];
        ZExponentPosition = [XMax + (XRange * AxLabelOffset) YMax ZMax];
    else
    end
    if ViewAngle(1) >= 270 && ViewAngle(1) < 360
        XLabelPosition = [XMid YMin - (YRange * AxLabelOffset) ZMin];
        YLabelPosition = [XMin - (XRange * AxLabelOffset) YMid ZMin];
        ZLabelPosition = [XMin YMax + (YRange * AxLabelOffset) ZMid];
        XExponentPosition = [XMin YMin - (AxLabelOffset * YRange) ZMin];
        YExponentPosition = [XMin - (AxLabelOffset * XRange) YMax ZMin];
        ZExponentPosition = [XMin YMax + (AxLabelOffset * YRange) ZMax];
    else
    end
    FigXOrigin = (ResPoints(3) / 2) - (XFigWidth / 2);
    FigYOrigin = (ResPoints(4) / 2) - (YFigWidth / 2);
    FigPosition = [FigXOrigin FigYOrigin XFigWidth YFigWidth];
    CBarExponentXYZ = [XAxisWidth + (0.25 * BoxMarginWidth) YAxisWidth + (0.5 * FontSize) 0];
end

% Create ticks and labels
LatexToggle = strcmp(Interpreter, 'latex');
if isempty(XTicks)
    [XTicks, XTickLabels, XExponentLabel] = createTicksAndLabels(XMin, XMax, double(NXTicks), XTickFormat, LatexToggle, UseXTickFractions, UseXScientificNotation);
else
    [XTickLabels, XExponentLabel] = createLabels(XTicks, XTickFormat, LatexToggle, UseXTickFractions, UseXScientificNotation);
end
if isempty(YTicks)
    [YTicks, YTickLabels, YExponentLabel] = createTicksAndLabels(YMin, YMax, double(NYTicks), YTickFormat, LatexToggle, UseYTickFractions, UseYScientificNotation);
else
    [YTickLabels, YExponentLabel] = createLabels(YTicks, YTickFormat, LatexToggle, UseYTickFractions, UseYScientificNotation);
end
if isempty(ZTicks)
    [ZTicks, ZTickLabels, ZExponentLabel] = createTicksAndLabels(ZMin, ZMax, double(NZTicks), ZTickFormat, LatexToggle, UseZTickFractions, UseZScientificNotation);
else
    [ZTickLabels, ZExponentLabel] = createLabels(ZTicks, ZTickFormat, LatexToggle, UseZTickFractions, UseZScientificNotation);
end
if isempty(CBarTicks)
    [CBarTicks, CBarTickLabels, CBarExponentLabel] = createTicksAndLabels(CBarMin, CBarMax, double(NCBarTicks), CBarTickFormat, LatexToggle, UseCBarTickFractions, UseCBarScientificNotation);
else
    [YTickLabels, YExponentLabel] = createLabels(YTicks, YTickFormat, LatexToggle, UseYTickFractions, UseYScientificNotation);
end

% Set figure properties
fig = figure;
set(fig, 'Units', 'Points');
set(fig, 'Color', [1 1 1]);
set(fig, 'InnerPosition', double(FigInnerPosition));
set(fig, 'Position', double(FigPosition));
set(fig, 'Renderer', 'painter');

% Create axes
ta = gca;
axis on;
ta.Units = 'Points';
ta.PositionConstraint = 'innerposition';
ta.ALim = [AlphaMin AlphaMax];
ta.Alphamap = linspace(AlphaMin, AlphaMax, 10001);
ta.Box = 'off';
ta.BoxStyle = 'back';
ta.CLim = [double(CBarMin) double(CBarMax)];
ta.Color = [1 1 1];
ta.DataAspectRatio = [1 1 1];
ta.FontName = FontName;
ta.FontSize = double(FontSize);
ta.FontWeight = AxisFontWeight;
ta.FontUnits = 'Points';
ta.GridColor = [0 0 0];
ta.LabelFontSizeMultiplier = 1;
ta.LineWidth = LineWidth;
ta.MinorGridColor = [0 0 0];
ta.Position = double(AxisPosition);
ta.TickLabelInterpreter = Interpreter;
ta.View = [0 90];

% Create title
ta.Title.Units = 'Points';
ta.Title.Color = [0 0 0];
ta.Title.FontName = FontName;
ta.Title.FontSize = double(FontSize);
ta.Title.FontUnits = 'Points';
ta.Title.FontWeight = TitleFontWeight;
ta.Title.HorizontalAlignment = 'Center';
ta.Title.Interpreter = Interpreter;
ta.Title.LineWidth = LineWidth;
ta.Title.Units = 'Points';
ta.Title.Position = double(TitlePosition);
ta.Title.String = TitleString;
ta.Title.VerticalAlignment = 'Middle';

% Create colorbar
if UseColorBar == true
    C = colorbar;
    C.Units = 'Points';
    C.Color = [0 0 0];
    C.FontName = FontName;
    C.FontSize = double(FontSize);
    C.FontWeight = AxisFontWeight;
    C.Label.Units = 'Points';
    C.Label.Color = [0 0 0];
    C.Label.FontName = FontName;
    C.Label.FontSize = double(FontSize);
    C.Label.FontUnits = 'Points';
    C.Label.FontWeight = LabelFontWeight;
    C.Label.HorizontalAlignment = 'Center';
    C.Label.Interpreter = Interpreter;
    C.Label.Position = double(CBarLabelPosition);
    C.Label.String = CBarLabelString;
    C.Label.LineWidth = LineWidth;
    C.Label.VerticalAlignment = 'Middle';
    C.Limits = [double(CBarMin) double(CBarMax)];
    C.LineWidth = LineWidth;
    C.Position = double(CBarPosition);
    C.TickLabelInterpreter = Interpreter;
    C.TickLabels = CBarTickLabels;
    C.Ticks = double(CBarTicks);
    C.Visible = 'on';
else
end

% Write colorbar exponent label
CBarExponentText = text(0, 0, CBarExponentLabel);
CBarExponentText.Units = 'Points';
CBarExponentText.BackgroundColor = 'None';
CBarExponentText.Color = [0 0 0];
CBarExponentText.FontName = FontName;
CBarExponentText.FontSize = double(FontSize);
CBarExponentText.FontUnits = 'Points';
CBarExponentText.FontWeight = LabelFontWeight;
CBarExponentText.HandleVisibility = 'Off';
CBarExponentText.HorizontalAlignment = 'Left';
CBarExponentText.Interpreter = Interpreter;
CBarExponentText.LineStyle = '-';
CBarExponentText.LineWidth = LineWidth;
CBarExponentText.Position = double(CBarExponentXYZ);
CBarExponentText.String = CBarExponentLabel;
CBarExponentText.VerticalAlignment = 'Bottom';

% Create blank x axis
ta.XAxis.Color = [0 0 0];
ta.XAxis.FontName = FontName;
ta.XAxis.FontSize = double(FontSize);
ta.XAxis.FontWeight = AxisFontWeight;
ta.XAxis.HandleVisibility = 'off';
ta.XAxis.Label = [];
ta.XAxis.Limits = [0 1];
ta.XAxis.LineWidth = LineWidth;
ta.XAxis.TickLabelInterpreter = Interpreter;
ta.XAxis.TickLabels = '';
ta.XAxis.TickValues = [];
ta.XAxis.Visible = 'off';
ta.XColor = [0 0 0];
ta.XGrid = 'off';
ta.XLabel.BackgroundColor = 'None';
ta.XLabel.Color = [0 0 0];
ta.XLabel.FontName = FontName;
ta.XLabel.FontSize = double(FontSize);
ta.XLabel.FontUnits = 'Points';
ta.XLabel.FontWeight = LabelFontWeight;
ta.XLabel.HandleVisibility = 'off';
ta.XLabel.HorizontalAlignment = 'Center';
ta.XLabel.Interpreter = Interpreter;
ta.XLabel.LineWidth = LineWidth;
ta.XLabel.Position = [0.5 -0.1 0];
ta.XLabel.String = '';
ta.XLabel.Units = 'data';
ta.XLabel.VerticalAlignment = 'Middle';
ta.XLabel.Visible = 'off';
ta.XLim = [0 1];
ta.XTick = [];
ta.XTickLabel = '';

% Create blank y axis
ta.YAxis.Color = [0 0 0];
ta.YAxis.FontName = FontName;
ta.YAxis.FontSize = double(FontSize);
ta.YAxis.FontWeight = AxisFontWeight;
ta.YAxis.HandleVisibility = 'off';
ta.YAxis.Label = [];
ta.YAxis.Limits = [0 1];
ta.YAxis.LineWidth = LineWidth;
ta.YAxis.TickLabelInterpreter = Interpreter;
ta.YAxis.TickLabels = '';
ta.YAxis.TickValues = [];
ta.YAxis.Visible = 'off';
ta.YColor = [0 0 0];
ta.YGrid = 'off';
ta.YLabel.BackgroundColor = 'None';
ta.YLabel.Color = [0 0 0];
ta.YLabel.FontName = FontName;
ta.YLabel.FontSize = double(FontSize);
ta.YLabel.FontWeight = LabelFontWeight;
ta.YLabel.FontUnits = 'Points';
ta.YLabel.HandleVisibility = 'off';
ta.YLabel.HorizontalAlignment = 'Center';
ta.YLabel.Interpreter = Interpreter;
ta.YLabel.LineWidth = LineWidth;
ta.YLabel.Position = [0.5 -0.1 0];
ta.YLabel.String = '';
ta.YLabel.Units = 'data';
ta.YLabel.VerticalAlignment = 'Middle';
ta.YLabel.Visible = 'off';
ta.YLim = [0 1];
ta.YTick = [];
ta.YTickLabel = '';

% Create blank z axis
ta.ZAxis.Color = [0 0 0];
ta.ZAxis.FontName = FontName;
ta.ZAxis.FontSize = double(FontSize);
ta.ZAxis.FontWeight = AxisFontWeight;
ta.ZAxis.HandleVisibility = 'off';
ta.ZAxis.Label = [];
ta.ZAxis.Limits = [0 1];
ta.ZAxis.LineWidth = LineWidth;
ta.ZAxis.TickLabelInterpreter = Interpreter;
ta.ZAxis.TickLabels = '';
ta.ZAxis.TickValues = [];
ta.ZAxis.Visible = 'off';
ta.ZColor = [0 0 0];
ta.ZGrid = 'off';
ta.ZLabel.BackgroundColor = 'None';
ta.ZLabel.Color = [0 0 0];
ta.ZLabel.FontName = FontName;
ta.ZLabel.FontSize = double(FontSize);
ta.ZLabel.FontUnits = 'Points';
ta.ZLabel.FontWeight = LabelFontWeight;
ta.ZLabel.HandleVisibility = 'off';
ta.ZLabel.HorizontalAlignment = 'Center';
ta.ZLabel.Interpreter = Interpreter;
ta.ZLabel.LineWidth = LineWidth;
ta.ZLabel.Position = [0.5 -0.1 0];
ta.ZLabel.String = '';
ta.ZLabel.Units = 'data';
ta.ZLabel.VerticalAlignment = 'Middle';
ta.ZLabel.Visible = 'off';
ta.ZLim = [0 1];
ta.ZTick = [];
ta.ZTickLabel = '';

% Create primary axis
ax = axes;
axis on;
hold on;
ax.Units = 'Points';
ax.PositionConstraint = 'innerposition';
ax.ALim = [AlphaMin AlphaMax];
ax.Alphamap = linspace(AlphaMin, AlphaMax, 10001);
if UseBorder == true
    ax.Box = 'on';
else
    ax.Box = 'off';
end
ax.BoxStyle = 'back';
ax.CLim = [double(CBarMin) double(CBarMax)];
ax.Color = [1 1 1];
ax.FontName = FontName;
ax.FontSize = double(FontSize);
ax.FontUnits = 'Points';
ax.FontWeight = AxisFontWeight;
ax.GridColor = [0 0 0];
ax.LabelFontSizeMultiplier = 1;
ax.LineWidth = LineWidth;
ax.MinorGridColor = [0 0 0];
ax.PlotBoxAspectRatio = [1 1 1];
ax.Position = double(AxisPosition);
ax.PositionConstraint = 'innerposition';
ax.TickLabelInterpreter = Interpreter;
ax.View = double(ViewAngle);

% Create x axis
ax.XAxis.Color = [0 0 0];
ax.XAxis.FontName = FontName;
ax.XAxis.FontSize = double(FontSize);
ax.XAxis.FontWeight = AxisFontWeight;
ax.XAxis.HandleVisibility = 'off';
ax.XAxis.Label.Color = [0 0 0];
ax.XAxis.Label.FontName = FontName;
ax.XAxis.Label.FontSize = double(FontSize);
ax.XAxis.Label.FontUnits = 'Points';
ax.XAxis.Label.FontWeight = LabelFontWeight;
ax.XAxis.Label.HandleVisibility = 'off';
ax.XAxis.Label.HorizontalAlignment = 'Center';
ax.XAxis.Label.Interpreter = Interpreter;
ax.XAxis.Label.LineWidth = LineWidth;
ax.XAxis.Label.Units = 'data';
ax.XAxis.Label.Position = double(XLabelPosition);
ax.XAxis.Label.String = XLabelString;
ax.XAxis.Label.VerticalAlignment = 'Middle';
ax.XAxis.Label.Visible = 'on';
ax.XAxis.Limits = [double(XMin) double(XMax)];
ax.XAxis.LineWidth = LineWidth;
if UseMinorTick == true
    ax.XAxis.MinorTick = 'on';
else
    ax.XAxis.MinorTick = 'off';
end
ax.XAxis.TickLabelInterpreter = Interpreter;
ax.XAxis.TickLabels = XTickLabels;
ax.XAxis.TickValues = double(XTicks);
if UseXAxis == true
    ax.XAxis.Visible = 'on';
else
    ax.XAxis.Visible = 'off';
end
ax.XColor = [0 0 0];
if UseGrid == true
    ax.XGrid = 'on';
else
    ax.XGrid = 'off';
end
ax.XLabel.BackgroundColor = 'None';
ax.XLabel.Color = [0 0 0];
ax.XLabel.FontName = FontName;
ax.XLabel.FontSize = double(FontSize);
ax.XLabel.FontUnits = 'Points';
ax.XLabel.FontWeight = LabelFontWeight;
ax.XLabel.HandleVisibility = 'off';
ax.XLabel.HorizontalAlignment = 'Center';
ax.XLabel.Interpreter = Interpreter;
ax.XLabel.LineWidth = LineWidth;
ax.XLabel.Units = 'data';
ax.XLabel.Position = double(XLabelPosition);
ax.XLabel.String = XLabelString;
ax.XLabel.VerticalAlignment = 'Middle';
ax.XLabel.Visible = 'on';
ax.XLim = [double(XMin) double(XMax)];
ax.XTick = double(XTicks);
ax.XTickLabel = XTickLabels;

% Create y axis
ax.YAxis.Color = [0 0 0];
ax.YAxis.FontName = FontName;
ax.YAxis.FontSize = double(FontSize);
ax.YAxis.FontWeight = AxisFontWeight;
ax.YAxis.HandleVisibility = 'off';
ax.YAxis.Label.Color = [0 0 0];
ax.YAxis.Label.FontName = FontName;
ax.YAxis.Label.FontSize = double(FontSize);
ax.YAxis.Label.FontUnits = 'Points';
ax.YAxis.Label.FontWeight = LabelFontWeight;
ax.YAxis.Label.HandleVisibility = 'off';
ax.YAxis.Label.HorizontalAlignment = 'Center';
ax.YAxis.Label.Interpreter = Interpreter;
ax.YAxis.Label.LineWidth = LineWidth;
ax.YAxis.Label.Units = 'data';
ax.YAxis.Label.Position = double(YLabelPosition);
ax.YAxis.Label.String = YLabelString;
ax.YAxis.Label.VerticalAlignment = 'Middle';
ax.YAxis.Label.Visible = 'on';
ax.YAxis.Limits = [double(YMin) double(YMax)];
ax.YAxis.LineWidth = LineWidth;
if UseMinorTick == true
    ax.YAxis.MinorTick = 'on';
else
    ax.YAxis.MinorTick = 'off';
end
ax.YAxis.TickLabelInterpreter = Interpreter;
ax.YAxis.TickLabels = YTickLabels;
ax.YAxis.TickValues = double(YTicks);
if UseYAxis == true
    ax.YAxis.Visible = 'on';
else
    ax.YAxis.Visible = 'off';
end
ax.YColor = [0 0 0];
if UseGrid == true
    ax.YGrid = 'on';
else
    ax.YGrid = 'off';
end
ax.YLabel.BackgroundColor = 'None';
ax.YLabel.Color = [0 0 0];
ax.YLabel.FontName = FontName;
ax.YLabel.FontSize = double(FontSize);
ax.YLabel.FontUnits = 'Points';
ax.YLabel.FontWeight = LabelFontWeight;
ax.YLabel.HandleVisibility = 'off';
ax.YLabel.HorizontalAlignment = 'Center';
ax.YLabel.Interpreter = Interpreter;
ax.YLabel.LineWidth = LineWidth;
ax.YLabel.Units = 'data';
ax.YLabel.Position = double(YLabelPosition);
ax.YLabel.String = YLabelString;
ax.YLabel.VerticalAlignment = 'Middle';
ax.YLabel.Visible = 'on';
ax.YLim = [double(YMin) double(YMax)];
ax.YTick = double(YTicks);
ax.YTickLabel = YTickLabels;

% Create z axis
ax.ZAxis.Color = [0 0 0];
ax.ZAxis.FontName = FontName;
ax.ZAxis.FontSize = double(FontSize);
ax.ZAxis.FontWeight = AxisFontWeight;
ax.ZAxis.HandleVisibility = 'off';
ax.ZAxis.Label.Color = [0 0 0];
ax.ZAxis.Label.FontName = FontName;
ax.ZAxis.Label.FontSize = double(FontSize);
ax.ZAxis.Label.FontUnits = 'Points';
ax.ZAxis.Label.FontWeight = LabelFontWeight;
ax.ZAxis.Label.HandleVisibility = 'off';
ax.ZAxis.Label.HorizontalAlignment = 'Center';
ax.ZAxis.Label.Interpreter = Interpreter;
ax.ZAxis.Label.LineWidth = LineWidth;
ax.ZAxis.Label.Units = 'data';
ax.ZAxis.Label.Position = double(ZLabelPosition);
ax.ZAxis.Label.String = ZLabelString;
ax.ZAxis.Label.VerticalAlignment = 'Middle';
ax.ZAxis.Label.Visible = 'on';
ax.ZAxis.Limits = [double(ZMin) double(ZMax)];
ax.ZAxis.LineWidth = LineWidth;
if UseMinorTick == true
    ax.ZAxis.MinorTick = 'on';
else
    ax.ZAxis.MinorTick = 'off';
end
ax.ZAxis.TickLabelInterpreter = Interpreter;
ax.ZAxis.TickLabels = ZTickLabels;
ax.ZAxis.TickValues = double(ZTicks);
if UseZAxis == true
    ax.ZAxis.Visible = 'on';
else
    ax.ZAxis.Visible = 'off';
end
ax.ZColor = [0 0 0];
if UseGrid == true
    ax.ZGrid = 'on';
else
    ax.ZGrid = 'off';
end
ax.ZLabel.BackgroundColor = 'None';
ax.ZLabel.Color = [0 0 0];
ax.ZLabel.FontName = FontName;
ax.ZLabel.FontSize = double(FontSize);
ax.ZLabel.FontUnits = 'Points';
ax.ZLabel.FontWeight = LabelFontWeight;
ax.ZLabel.HandleVisibility = 'off';
ax.ZLabel.HorizontalAlignment = 'Center';
ax.ZLabel.Interpreter = Interpreter;
ax.ZLabel.LineWidth = LineWidth;
ax.ZLabel.Units = 'data';
ax.ZLabel.Position = double(ZLabelPosition);
ax.ZLabel.String = ZLabelString;
ax.ZLabel.VerticalAlignment = 'Middle';
ax.ZLabel.Visible = 'on';
ax.ZLim = [double(ZMin) double(ZMax)];
ax.ZTick = double(ZTicks);
ax.ZTickLabel = ZTickLabels;

% Write x axis exponent label
XExponentText = text(0, 0, XExponentLabel);
XExponentText.Units = 'Data';
XExponentText.BackgroundColor = 'None';
XExponentText.Color = [0 0 0];
XExponentText.FontName = FontName;
XExponentText.FontSize = double(FontSize);
XExponentText.FontUnits = 'Points';
XExponentText.FontWeight = AxisFontWeight;
XExponentText.HandleVisibility = 'Off';
XExponentText.HorizontalAlignment = 'Center';
XExponentText.Interpreter = Interpreter;
XExponentText.LineStyle = '-';
XExponentText.LineWidth = LineWidth;
XExponentText.Position = double(XExponentPosition);
XExponentText.String = XExponentLabel;
XExponentText.VerticalAlignment = 'Middle';

% Write y axis exponent label
YExponentText = text(0, 0, YExponentLabel);
YExponentText.Units = 'Data';
YExponentText.BackgroundColor = 'None';
YExponentText.Color = [0 0 0];
YExponentText.FontName = FontName;
YExponentText.FontSize = double(FontSize);
YExponentText.FontUnits = 'Points';
YExponentText.FontWeight = AxisFontWeight;
YExponentText.HandleVisibility = 'Off';
YExponentText.HorizontalAlignment = 'Center';
YExponentText.Interpreter = Interpreter;
YExponentText.LineStyle = '-';
YExponentText.LineWidth = LineWidth;
YExponentText.Position = double(YExponentPosition);
YExponentText.String = YExponentLabel;
YExponentText.VerticalAlignment = 'Middle';

% Write z axis exponent label
ZExponentText = text(0, 0, ZExponentLabel);
ZExponentText.Units = 'Data';
ZExponentText.BackgroundColor = 'None';
ZExponentText.Color = [0 0 0];
ZExponentText.FontName = FontName;
ZExponentText.FontSize = double(FontSize);
ZExponentText.FontUnits = 'Points';
ZExponentText.FontWeight = AxisFontWeight;
ZExponentText.HandleVisibility = 'Off';
ZExponentText.HorizontalAlignment = 'Center';
ZExponentText.Interpreter = Interpreter;
ZExponentText.LineStyle = '-';
ZExponentText.LineWidth = LineWidth;
ZExponentText.Position = double(ZExponentPosition);
ZExponentText.String = ZExponentLabel;
ZExponentText.VerticalAlignment = 'Middle';

end
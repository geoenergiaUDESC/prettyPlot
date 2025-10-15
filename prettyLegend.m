function prettyLegend(varargin)

% Create parser
p = inputParser;

% Interpreter parameters
addParameter(p, 'LegendInterpreter', 'latex');
addParameter(p, 'TitleInterpreter', 'latex');

% Font parameters
addParameter(p, 'FontName', 'Times');
addParameter(p, 'FontSize', 10);
addParameter(p, 'LegendFontWeight', 'Normal');
addParameter(p, 'TitleFontWeight', 'Bold');

% Legend parameters
addParameter(p, 'Legend', strings(1));
addParameter(p, 'NumColumns', 1);
addParameter(p, 'Title', strings(1));

% Aesthetic parameters
addParameter(p, 'LineWidth', 0.5);
addParameter(p, 'Position', 'NorthEast');

% Parse
parse(p, varargin{:});

% Parsed interpreter parameters
LegendInterpreter = p.Results.LegendInterpreter;
TitleInterpreter = p.Results.TitleInterpreter;

% Parsed font parameters
FontName = p.Results.FontName;
FontSize = p.Results.FontSize;
LegendFontWeight = p.Results.LegendFontWeight;
TitleFontWeight = p.Results.TitleFontWeight;

% Parsed legend parameters
LegendString = p.Results.Legend;
NumColumns = p.Results.NumColumns;
TitleString = p.Results.Title;

% Aesthetic parameters
LineWidth = p.Results.LineWidth;
Position = p.Results.Position;

% Create legend
L = legend;
L.Units = 'Points';
L.Box = 'On';
L.Color = [1 1 1];
L.EdgeColor = [0 0 0];
L.FontName = FontName;
L.FontSize = FontSize;
L.FontWeight = LegendFontWeight;
L.Interpreter = LegendInterpreter;
L.LineWidth = LineWidth;
L.Location = Position;
L.NumColumns = NumColumns;
L.TextColor = [0 0 0];
L.Title.Color = [0 0 0];
L.Title.FontName = FontName;
L.Title.FontSize = FontSize;
L.Title.FontWeight = TitleFontWeight;
L.Title.Interpreter = TitleInterpreter;
L.Title.String = TitleString;
L.String = LegendString;

end
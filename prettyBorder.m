function prettyBorder(varargin)

p = inputParser;
addParameter(p, 'XLim', [-5 5]);
addParameter(p, 'YLim', [-5 5]);
addParameter(p, 'LineWidth', 0.5);
parse(p, varargin{:});
XMin = p.Results.XLim(1);
XMax = p.Results.XLim(2);
YMin = p.Results.YLim(1);
YMax = p.Results.YLim(2);
LineWidth = p.Results.LineWidth;

% Create border
line([XMin XMax XMax XMin XMin], ...
    [YMin YMin YMax YMax YMin], ...
    [1 1 1 1 1], ...
    'Color', [0 0 0], ...
    'HandleVisibility', 'off', ...
    'LineStyle', '-', ...
    'LineWidth', LineWidth);

end
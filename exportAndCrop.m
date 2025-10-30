function exportAndCrop(fileName, varargin)

% Create parser
p = inputParser;

% Axis parameters
addParameter(p, 'horizontalCrop', false);
addParameter(p, 'verticalCrop', true);
addParameter(p, 'close', true);

% Parse the input
parse(p, varargin{:});

% Export the figure
export_fig(sprintf(fileName), ...
    "-r600", ...
    "-painters", ...
    "-q101", ...
    "-a4", ...
    "-nocrop");
if p.Results.close == true
    close all;
end

% Crop the figure if desired
if p.Results.verticalCrop == true
    removeVerticalWhitespace(fileName);
end

if p.Results.horizontalCrop == true
    removeHorizontalWhitespace(fileName);
end

end
function [tickVals, tickLabels, exponentLabel, subtickVals] = createTicksAndLabels(Min, Max, NTicks, ...
    TickFormat, ...
    LatexToggle, UseTickFractions, UseScientificNotation, logScale)

% Create the ticks and subticks for the appropriate axis scale
[tickVals, subtickVals, ~] = ticksAndSubticks([Min Max], NTicks, logScale);

% Get the mantissae and the exponents of the ticks
[mantissae, exponents] = mantissaAndExponent(tickVals, logScale);

% Create the exponent label
if UseScientificNotation == true
    exponentLabel = strcat('$\times 10^{', string(exponents(end)), '}$');
else
    exponentLabel = "";
end

% Create the tick labels
tickLabels = createLabel(mantissae, UseTickFractions, LatexToggle, TickFormat);

end
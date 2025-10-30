function [tickVals, tickLabels, exponentLabel, subtickVals] = createTicksAndLabels(Min, Max, NTicks, ...
    TickFormat, ...
    LatexToggle, UseTickFractions, UseScientificNotation, logScale)

% Create the ticks and subticks for the appropriate axis scale
[tickVals, subtickVals, ~] = ticksAndSubticks([Min Max], NTicks, logScale);

% Get the mantissae and the exponents of the ticks
[mantissae, exponents] = mantissaAndExponent(tickVals, logScale, UseScientificNotation);

% Create the tick labels - identical call for normal and scientific
tickLabels = createLabel(mantissae, UseTickFractions, LatexToggle, TickFormat);

% Create the exponent label for scientific notation
if UseScientificNotation
    exponentLabel = strcat('$\times 10^{', string(exponents(end)), '}$');
else
    exponentLabel = "";
end

end
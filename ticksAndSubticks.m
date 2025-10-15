function [plot_ticks, plot_subticks, nTicks] = ticksAndSubticks(xLim, nTicks, logScale)

% Get the numerical values of the subticks
if (logScale == true)

    % It is log scale, so we will override the specified limits of the plot
    pow = log10(xLim);

    % Widen the limits to acommodate xLim in powers of 10
    widest_power = [floor(pow(1)) ceil(pow(2))];
    plot_powers = widest_power(1) : sym(cast(1, 'uint64')) : widest_power(2);
    plot_ticks = sym(cast(10, 'uint64')) .^ plot_powers;
    nSubticks = cast(10, 'uint64');
    plot_subticks = sym(zeros(1, nSubticks * (length(plot_ticks) - 1)));
    for a = 1 : 1 : length(plot_ticks) - 1
        plot_subticks((1 : 1 : nSubticks) + ((a - 1) * nSubticks)) = linspace(plot_ticks(a), plot_ticks(a + 1), nSubticks);
    end
    plot_subticks = unique(plot_subticks, 'Stable');
    nTicks = cast(length(plot_ticks), 'uint64');
else

    % Not log scale, so just do a linear scale between the specified limits
    plot_ticks = linspace(xLim(1), xLim(2), nTicks);
    plot_subticks = linspace(xLim(1), xLim(2), (((nTicks - sym(cast(1, 'uint64'))) * ((nTicks - sym(cast(1, 'uint64'))) * sym(cast(10, 'uint64')))) / (nTicks - sym(cast(1, 'uint64')))) + sym(cast(1, 'uint64')));
    nTicks = cast(length(plot_ticks), 'uint64');
end

end
function [tickLabels, exponentLabel] = createLabels(Ticks, TickFormat, LatexToggle, UseTickFractions, UseScientificNotation)

% Toggle scientific notation off if using fractions
if UseTickFractions == true
    UseScientificNotation = false;
end

% Check if symbolic toolbox is installed
symtoggle = license('test', 'symbolic_toolbox');
if symtoggle == 1
    Ticks = sym(Ticks);
    tickLabels = strings(1, length(Ticks));
    if UseTickFractions == false
        if UseScientificNotation == false
            for a = 1 : 1 : length(Ticks)
                if LatexToggle == true
                    tickLabels(a) = strcat('$', num2str(double(simplify(Ticks(a), 'Steps', 100)), TickFormat), '$');
                else
                    tickLabels(a) = strcat(num2str(double(simplify(Ticks(a), 'Steps', 100)), TickFormat));
                end
            end
        else
        end
        if UseScientificNotation == true
            exponent = double(floor(log10(Ticks(end))));
            if LatexToggle == true
                exponentLabel = strcat('$\times 10^{', num2str(exponent, '%0.0f'), '}$');
            else
                exponentLabel = strcat('\times {10^{', num2str(exponent, '%0.0f'), '}}');
            end
            for a = 1 : 1 : length(Ticks)
                if LatexToggle == true
                    tickLabels(a) = strcat('$', num2str(double(simplify(Ticks(a) / (sym(10) ^ exponent), 'Steps', 100)), TickFormat), '$');
                else
                    tickLabels(a) = strcat(num2str(double(simplify(Ticks(a) / (sym(10) ^ exponent), 'Steps', 100)), TickFormat));
                end
            end
        end
    end
    if UseTickFractions == true
        if LatexToggle == true
            for a = 1 : 1 : length(Ticks)
                tickLabels(a) = strcat('$', latex(simplify(Ticks(a), 'Steps', 100)), '$');
            end
        else
            for a = 1 : 1 : length(Ticks)
                [Num, Den] = numden(Ticks(a));
                if Den == 1
                    tickLabels(a) = num2str(double(Num));
                else
                    tickLabels(a) = strcat('^{', num2str(double(Num)), '}/_{', num2str(double(Den)), '}');
                end
            end
        end
    end
else
    tickLabels = strings(1, length(Ticks));
    if UseScientificNotation == false
        for a = 1 : 1 : length(Ticks)
            if LatexToggle == true
                tickLabels(a) = strcat('$', num2str(double(Ticks(a)), TickFormat), '$');
            else
                tickLabels(a) = num2str(double(Ticks(a)), TickFormat);
            end
        end
    end
    if UseScientificNotation == true
        exponent = double(floor(log10(Ticks(end))));
        if LatexToggle == true
            exponentLabel = strcat('$\times 10^{', num2str(exponent, '%0.0f'), '}$');
        else
            exponentLabel = strcat('\times 10^{', num2str(exponent, '%0.0f'), '}');
        end
        for a = 1 : 1 : length(Ticks)
            if LatexToggle == true
                tickLabels(a) = strcat('$', num2str(double(Ticks(a) / (sym(10) ^ exponent)), TickFormat), '$');
            else
                tickLabels(a) = strcat(num2str(double(Ticks(a) / (sym(10) ^ exponent)), TickFormat));
            end
        end
    end
end
if not(exist('exponentLabel', 'var'))
    exponentLabel = '';
end
end
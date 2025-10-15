function label = createLabel(value, useFractions, LaTeX, tickFormat)

label = strings(size(value));

if LaTeX == true
    if useFractions == true
        for a = 1 : 1 : length(label)
            label(a) = "$" + latex(value(a)) + "$";
        end
    else
        for a = 1 : 1 : length(label)
            label(a) = "$" + string(num2str(cast(value(a), 'double'), tickFormat)) + "$";
        end
    end
else
    for a = 1 : 1 : length(label)
        label(a) = string(value(a));
    end
end

end
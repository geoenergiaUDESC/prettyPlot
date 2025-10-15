function [mantissa, exponent] = mantissaAndExponent(number, logScale)

if (logScale == true)
    exponent = sym(cast(zeros(size(number)), 'uint64')) + sym(cast(floor(log10(number(end))), 'int64'));
    mantissa = number ./ (sym(cast(10, 'uint64')) .^ exponent);
else
    exponent = sym(cast(zeros(size(number)), 'uint64'));
    mantissa = number;
end

end
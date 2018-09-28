function root = find_root_bisection(fm,xl,xu,precision)
%Description: find the root within the bracket of xl and xu
%Input: bracket of xl and xu of which within lies the root
%Output: the root to a precision of 1e-4

fxu = fm(xu);
fxr = 100;
ite = 0;
while abs(fxr) > precision && ite < 1000 %finding the root by bisection method with limit of 1000 iterations
    xr = 0.5*(xl + xu);
    fxr = fm(xr);
    if fxu*fxr > 0  %if both xl and xr are of same sign,new xl is xr
        xu = xr;
        fxu = fxr;
    else
        xl = xr;  %if xl and xr are of different signs,new xu is xr
    end
    ite = ite + 1;
end

if ite >= 1000
    root = NaN;
else
    root = xr;  %found the root with precision of 1e-4
end

end
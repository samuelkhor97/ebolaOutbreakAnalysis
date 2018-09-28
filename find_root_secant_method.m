function root = find_root_secant_method(fx,xi,xii,precision)
%Description: find the root with starting guesses xi & xii
%Input: guesses of xi & xii
%Output: the root to a precision of 0.1

fxiii = 100;
while abs(fxiii) > precision  %finding the root by secant method
    fxi = fx(xi);
    fxii = fx(xii);
    xiii = xii - (xii - xi)*fxii/(fxii - fxi);  %approximating the xiii value that intersects the x-axis(y=0)
    fxiii = fx(xiii);
    xi = xii;  %the new xi is now the current xii
    xii = xiii;  %the new xii is now the current xiii
end
root = xiii;  %found the root with precision of 0.1
end
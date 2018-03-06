%Creates greyscale from weighted RGB
function Grey = GreyLumPres(R, G, B)
    Grey = 0.2126*R + 0.7152*G + 0.0722*B;
end
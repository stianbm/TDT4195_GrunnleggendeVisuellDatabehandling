%Creates greyscale from average of RGB
function Grey = GreyAverage(R, G, B)
    Grey = (R + G + B)/3;
end
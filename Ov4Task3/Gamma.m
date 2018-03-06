%Alters the gamma of an intensity, assume input is uint8
function IntensOut = Gamma(IntensIn, gamma)
    %Normalise intensity in
    IntensIn = double(IntensIn);
    IntensIn = IntensIn / 255;
    IntensOut = uint8(255 * (IntensIn^gamma));
end
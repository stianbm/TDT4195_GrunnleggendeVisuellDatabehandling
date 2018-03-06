%Inverts the brightness for a uint8 intensity
function IntensOut = Invert(IntensIn)
    IntensOut = 256 - IntensIn;
end
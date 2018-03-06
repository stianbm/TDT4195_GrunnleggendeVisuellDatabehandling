%The function iterates over the kernel for one pixel
%   in the image
function outValue = kernelConvolutionColour(image, kernel, x, y, c)
    %Find size of kernel:
    kernelLength = size(kernel, 1);
    %Iterate over kernel
    value = 0;
    offset = ((kernelLength-1)/2) + 1;
    for i=1 : kernelLength
        for j=1 : kernelLength-1
           value = value + image(x - i + offset, y - j + offset, c)*kernel(i,j);
        end
    end
    %Return image
    outValue = value;
end
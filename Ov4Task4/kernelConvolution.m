%The function iterates over the kernel for one pixel
%   in the image
function outValue = kernelConvolution(image, kernel, x, y)
    %Find size of kernel:
    kernelLength = size(kernel, 1);
    %Iterate over kernel
    value = 0;
    offset = ((kernelLength-1)/2) + 1;
    for i=1 : kernelLength
        for j=1 : kernelLength-1
           value = value + image(x - offset + i, y - offset + j)*kernel(i,j);
        end
    end
    %Return image
    outValue = value;
end
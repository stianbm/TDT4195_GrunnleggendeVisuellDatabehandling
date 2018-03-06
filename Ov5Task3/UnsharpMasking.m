%Clear previous values
    clear
%Load image from "File.tiff"
    image = double(imread('C:\Users\stianbm\OneDrive\Documents\MATLAB\GrunVisDat5\fishingboat.tiff'));
%Get he information
    imageRow = size(image, 1);
    imageCol = size(image, 2);
%Copy image into corner of imagePad
    imagePad = (zeros(imageRow*2, imageCol*2));
    for i=1:imageRow
       for j=1:imageCol
          imagePad(i,j) = image(i,j);
       end
    end
%Center transform
    imageCentred = (zeros(imageRow*2, imageCol*2));
    for i=1:imageRow*2
       for j=1:imageCol*2
           imageCentred(i,j) = imagePad(i,j) * (-1)^(i+j);
       end
    end
%Fourier transform
    imageTransformed = fft2(double(imageCentred));  %Double
%LowPass
    lowPass = zeros(imageRow*2, imageCol*2);
    for i=1:imageRow*2
        for j=1:imageCol*2
            if ((i-imageRow)^2 + (j-imageCol)^2) <= 50^2
                lowPass(i,j) = 1;
            end
        end
    end
%"I - I_smooth"
    unsharp = zeros(imageRow*2, imageCol*2);
    for i=1:imageRow*2
       for j=1:imageCol*2
           unsharp(i,j) = 1 - lowPass(i,j);
       end
    end
%K
    k = 1;
%Kernel
    kernel = ones(imageRow*2, imageCol*2);
    for i=1:imageRow*2
       for j=1:imageCol*2
           kernel(i,j) = kernel(i,j) + k*unsharp(i,j);
       end
    end
%Filter
    imageFiltered = zeros(imageRow*2, imageCol*2);
    for i=1:imageRow*2
       for j=1:imageCol*2
           imageFiltered(i,j) = imageTransformed(i,j) * kernel(i,j);
       end
    end
%Inverse transform
    imageInvert = (ifft2(imageFiltered));   %Uint8
%Take real part
    imageReal = real(imageInvert);  %Uint8
%Decentre image
    imageDeCentred = (zeros(imageRow*2, imageCol*2));
    for i=1:imageRow*2
       for j=1:imageCol*2
           imageDeCentred(i,j) = imageReal(i,j) * (-1)^(i+j);
       end
    end
%crop the image
    imageCrop = (zeros(imageRow, imageCol));
    for i=1:imageRow
       for j=1:imageCol
          imageCrop(i,j) = imageDeCentred(i,j);
       end
    end
%Logarithmic
    imageTransformedLog = ((log(abs(imageTransformed))));
    kernelLog = ((log(abs(kernel))));
    imageFilteredLog = ((log(abs(imageFiltered))));
    for i=1:imageRow*2
       for j=1:imageCol*2
          imageTransformedLog(i,j) = imageTransformedLog(i,j) + 3;
          kernelLog(i,j) = kernelLog(i,j) + 3;
          imageFilteredLog(i,j) = imageFilteredLog(i,j) + 3;
       end
    end
%Show image
    figure('name', 'Original');
    imshow(uint8(image));
    figure('name', 'Transformed');
    imshow(uint8(imageTransformed));
    figure('name', 'LowPassFilter');
    imshow((lowPass));
    figure('name', 'unsharp');
    imshow((unsharp));
    figure('name', 'kernel');
    imshow((kernel));
    figure('name', 'imageFiltered');
    imshow(uint8(imageFiltered));
    figure('name', 'final');
    imshow(uint8(imageCrop));
    %Log
    figure('name', 'imageTransformedLog');
    imshow(uint8(imageTransformedLog));
    figure('name', 'kernelLog');
    imshow(uint8(kernelLog));
    figure('name', 'imageFilteredLog');
    imshow(uint8(imageFilteredLog));
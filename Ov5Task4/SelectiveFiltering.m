%Clear previous values
    clear
%Load image from "File.tiff"
    image = double(imread('C:\Users\stianbm\OneDrive\Documents\MATLAB\GrunVisDat5\noise-a.tiff'));
%Make a imagePad to hold the altered image
    imageRow = size(image, 1);
    imageCol = size(image, 2);
    imagePad = (zeros(imageRow*2, imageCol*2));
%Copy image into corner of imagePad
    for i=1:imageRow
       for j=1:imageCol
          imagePad(i,j) = image2(i,j);
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
    imageTransformed = fft2(double(imageCentred));
%Filter - The noise is vertical lines, so we try to filter out the
%horizontal mid-line in the logarithmic Fourier plot of the image.
    filter = ones(imageRow*2, imageCol*2);
    breadth = 5;
    for i=imageRow-breadth:imageRow+breadth
        for j=1:imageCol*2
            filter(i,j) = 0;
        end
    end
    %Make gap in centre
    for i=imageRow-breadth:imageRow+breadth
        for j=imageCol-3:imageCol+3
            filter(i,j) = 1;
        end
    end
    imageFiltered = zeros(imageRow*2, imageCol*2);
    for i=1:imageRow*2
        for j=1:imageCol*2
            imageFiltered(i,j) = imageTransformed(i,j) * filter(i,j);
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
    imageFilteredLog = ((log(abs(imageFiltered))));
    for i=1:imageRow*2
       for j=1:imageCol*2
          imageTransformedLog(i,j) = imageTransformedLog(i,j) + 20;
          imageFilteredLog(i,j) = imageFilteredLog(i,j) + 20;
       end
    end
%Show image
    figure('name', 'Original');
    imshow(uint8(image));
    figure('name', 'Transformed');
    imshow(uint8(imageTransformed));
    figure('name', 'TransformedLogarithmic');
    imshow(uint8(imageTransformedLog));
    figure('name', 'Filter');
    imshow((filter));
    figure('name', 'imageFilteredLog');
    imshow(uint8(imageFilteredLog));
    figure('name', 'Final');
    imshow(uint8(imageCrop));
%Clear previous values
    clear
%Load image from "File.tiff"
    image = double(imread('C:\Users\stianbm\OneDrive\Documents\MATLAB\GrunVisDat5\fishingboat.tiff'));
%Make a imagePad to hold the altered image
    imageRow = size(image, 1);
    imageCol = size(image, 2);
    imagePad = (zeros(imageRow*2, imageCol*2));
%Copy image into corner of imagePad
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
    imageTransformed = fft2(double(imageCentred));
%Kernel
    lowPass = zeros(imageRow*2, imageCol*2);
    kernel = ones(imageRow*2, imageCol*2);
    for i=imageRow-75:imageRow+75
       for j=imageCol-75:imageCol+75
          kernel(i,j) = 0;
          lowPass(i,j) = 1;
       end
    end
%Filter
    imageFiltered = zeros(imageRow*2, imageCol*2);
    imageLowPass = zeros(imageRow*2, imageCol*2);
    for i=1:imageRow*2
       for j=1:imageCol*2
           imageFiltered(i,j) = imageTransformed(i,j) * kernel(i,j);
           imageLowPass(i,j) = imageTransformed(i,j) * lowPass(i,j);
       end
    end
%Logarithmic
    imageLog = ((log(abs(imageTransformed))));
    imageLog2 = ((log(abs(imageFiltered))));
    imageLogLow = ((log(abs(imageLowPass))));
%Reverse transform image
    imageInvert = (ifft2(imageFiltered));
    imageInvertLow = (ifft2(imageLowPass));
%Take real part
    imageReal = real(imageInvert);
    imageLowReal = real(imageInvertLow);
%Decentre image
    imageDeCentred = (zeros(imageRow*2, imageCol*2));
    imageLowDe = (zeros(imageRow*2, imageCol*2));
    for i=1:imageRow*2
       for j=1:imageCol*2
           imageDeCentred(i,j) = imageReal(i,j) * (-1)^(i+j);
           imageLowDe(i,j) = imageLowReal(i,j) * (-1)^(i+j);
       end
    end
%crop the image
    imageCrop = (zeros(imageRow, imageCol));
    imageCropLow = (zeros(imageRow, imageCol));
    for i=1:imageRow
       for j=1:imageCol
          imageCrop(i,j) = imageDeCentred(i,j);
          imageCropLow(i,j) = imageLowDe(i,j);
       end
    end
%Show image
    figure('name', 'Original');
    imshow(uint8(image));
    figure('name', 'Transformed');
    imshow(uint8(imageTransformed));
    figure('name', 'Logarithmic');
    imshow(uint8(imageLog));
    figure('name', 'Logarithmic filtered');
    imshow(uint8(imageLog2));
    figure('name', 'Filter');
    imshow((kernel));
    figure('name', 'Filtered');
    imshow(uint8(imageFiltered));
    figure('name', 'Final');
    imshow(uint8(imageCrop));
    %LowPass
    figure('name', 'FinalLow');
    imshow(uint8(imageCropLow));
    figure('name', 'FourierLowFilter');
    imshow(uint8(imageLowPass));
    figure('name', 'LowPass');
    imshow((lowPass));
    figure('name', 'Logarithmic low filtered');
    imshow(uint8(imageLogLow));
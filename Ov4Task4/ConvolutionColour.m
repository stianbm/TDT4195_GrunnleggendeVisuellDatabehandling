%Clear previous values
clear
%Load image from "File.tiff"
image = imread('C:\Users\stian\OneDrive\Documents\MATLAB\GrunVisDat\Terraux.tiff');
whos image
%Make a NewImage to hold the altered image
imageRow = size(image, 1);
imageCol = size(image, 2);
newImage = uint8(zeros(imageRow, imageCol, 3));
newImage2 = uint8(zeros(imageRow, imageCol, 3));
%Create kernels:
averageKernel = (1/9) * ones(3,3);
gaussianKernel = (1/256) * [...
    1, 4, 6, 4,1;
    4,16,24,16,4;
    6,24,36,24,6;
    4,16,24,16,4;
    1, 4, 6, 4,1];
%Call convolution function:
for c=1 : 3
    for i=3 : (imageRow-2)
       for j=3 : (imageCol-2)
          newImage(i,j,c) = kernelConvolutionColour(image, averageKernel, i, j, c);
          newImage2(i,j,c) = kernelConvolutionColour(image, gaussianKernel, i, j, c);
       end
    end
end
%Print images
figure;
imshow(image);  %Figure1 - image
figure;
imshow(newImage);  %Figure2 - average
figure;
imshow(newImage2);  %Figure2 - gaussian
%Clear previous values
clear
%Load image from "File.tiff"
image = imread('C:\Users\stian\OneDrive\Documents\MATLAB\GrunVisDat\Aerial.tiff');
%Make a NewImage to hold the altered image
imageRow = size(image, 1);
imageCol = size(image, 2);
newImage = int8(zeros(imageRow, imageCol));
newImage2 = int8(zeros(imageRow, imageCol));
%Create kernels:
averageKernel = (1/9) * ones(3,3);
gaussianKernel = (1/256) * [...
    1, 4, 6, 4,1;
    4,16,24,16,4;
    6,24,36,24,6;
    4,16,24,16,4;
    1, 4, 6, 4,1];
%Call convolution function, just iterate over lgeal
%   area of image
for i=3 : (imageRow-2)
   for j=3 : (imageCol-2)
      newImage(i,j) = kernelConvolution(image, averageKernel, i, j);
      newImage2(i,j) = kernelConvolution(image, gaussianKernel, i, j);
   end
end
%Print images
figure;
imshow(image);  %Figure1 - image
figure;
imshow(newImage);  %Figure2 - average
figure;
imshow(newImage2);  %Figure2 - gaussian
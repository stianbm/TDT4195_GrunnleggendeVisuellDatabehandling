%Clear previous values
clear
%Load image from "File.tiff"
image = imread('C:\Users\stian\OneDrive\Documents\MATLAB\GrunVisDat\Fishingboat.tiff');
%Make a NewImage to hold the altered image
imageRow = size(image, 1);
imageCol = size(image, 2);
newImage = double(zeros(imageRow, imageCol));
newImage2 = double(zeros(imageRow, imageCol));
newImage3 = double(zeros(imageRow, imageCol));
image = double(image);
%Create kernels:
Ix = [...
    -1, 0, 1;
    -2, 0, 2;
    -1, 0, 1];
Iy = [...
    -1,-2,-1;
     0, 0, 0;
     1, 2, 1];
%Call convolution function, just iterate over legeal
%   area of image
for i=3 : (imageRow-2)
   for j=3 : (imageCol-2)
      newImage(i,j) = kernelConvolution(image, Ix, i, j);
      newImage2(i,j) = kernelConvolution(image, Iy, i, j);
      newImage3(i,j) = sqrt(newImage(i,j)*newImage(i,j) + newImage2(i,j)*newImage2(i,j));
   end
end
%Print images
newImage = int8(newImage);
newImage2 = int8(newImage2);
newImage3 = int8(newImage3);
image = int8(image);
figure;
imshow(image);  %Figure1 - image
figure;
imshow(newImage);  %Figure2 - Ix
figure;
imshow(newImage2);  %Figure3 - Iy
figure;
imshow(newImage3);  %Figure4 - grad
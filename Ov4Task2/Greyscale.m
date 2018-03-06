%Clear previous values
clear
%Load image from "File.tiff"
image = imread('C:\Users\stianbm\Documents\MATLAB\GrunVisDat\Lake.tiff');
%Make a NewImage to hold the altered image
ImageRow = size(image, 1);
ImageCol = size(image, 2);
NewImage = uint8(zeros(ImageRow, ImageCol));
NewImage2 = uint8(zeros(ImageRow, ImageCol));
%Use a function on all point in the image. Need to manually change the
%   image import
for i = 1:ImageRow
    for j = 1:ImageCol
        NewImage(i,j) = GreyLumPres(image(i,j,1), image(i,j,2), image(i,j,3));
        NewImage2(i,j) = GreyAverage(image(i,j,1), image(i,j,2), image(i,j,3));
    end
end
%Show image
figure;
imshow(image);  %Figure1
figure;
imshow(NewImage);   %Figure2
figure;
imshow(NewImage2);  %Figure3
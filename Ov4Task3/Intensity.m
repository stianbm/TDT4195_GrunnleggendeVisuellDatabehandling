%Clear previous values
clear
%Load image from "File.tiff"
image = imread('C:\Users\stianbm\Documents\MATLAB\GrunVisDat\Fishingboat.tiff');
%Make a NewImage to hold the altered image
whos image
ImageRow = size(image, 1);
ImageCol = size(image, 2);
NewImage = uint8(zeros(ImageRow, ImageCol));
%Use a function on all point in the image. Need to manually change the
%   image import and function applied
for i = 1:ImageRow
    for j = 1:ImageCol
        NewImage(i,j) = Gamma(image(i,j), 0.1);
    end
end
%Show image
figure;
imshow(image);  %Figure1
figure;
imshow(NewImage);   %Figure2
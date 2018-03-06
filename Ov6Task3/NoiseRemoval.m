%Clear previous values
    clear
%Load image from "File.tiff"
    image = double(imread('C:\Users\stianbm\Documents\MATLAB\GrunVisDatOv6\noisy.tiff'));
%Create structuring element
    SE = strel('disk',9);
%Close the image
    imageFiltered = imopen(image, SE);
    imageFiltered = imclose(imageFiltered, SE);
%Show image
    figure('name', 'Original');
    imshow(uint8(image));
    figure('name', 'Closed');
    imshow(uint8(imageFiltered));
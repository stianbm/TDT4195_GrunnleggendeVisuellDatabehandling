%Clear previous values
    clear
%Load image from "File.tiff"
    image = double(imread('C:\Users\stianbm\Documents\MATLAB\GrunVisDatOv6\noisy.tiff'));
%Create the binary image from previous task
    %Create structuring element
        SE = strel('disk',9);
    %Close the image
        imageFiltered = imopen(image, SE);
        imageFiltered = imclose(imageFiltered, SE);
%Create the new Structuring element
    SE = ones(3,3);
%create eroded image
    imageEroded = imerode(imageFiltered, SE);
%Subtract eroded image from original filtered image
    imageBoundary = imageFiltered - imageEroded;
%Show image
    figure('name', 'Original');
    imshow(uint8(image));
    figure('name', 'Filtered');
    imshow(uint8(imageFiltered));
    figure('name', 'Eroded');
    imshow(uint8(imageEroded));
    figure('name', 'Boundary');
    imshow(uint8(imageBoundary));
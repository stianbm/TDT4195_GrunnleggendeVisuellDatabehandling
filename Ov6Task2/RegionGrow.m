%The script does not take an arbitrary amount of seed points, but can
%easily be modified to do this by turning it into a function that takes
% seed points in arrays, and iterate over said arrays in the "Grow from
% seedpoint" part.

%Clear previous values and output
    clear
    clc
%Load image from "File.tiff"
    image = double(imread('C:\Users\stianbm\Documents\MATLAB\GrunVisDatOv6\weld.tiff'));
%Extract image information
    imageRow = size(image, 1);
    imageCol = size(image, 2);
%Choose threshold and seedpoints
    thresh = 30;
    seed1x = 251;
    seed1y = 295;
    seed2x = 255;
    seed2y = 140;
    seed3x = 240;
    seed3y = 441;
%Create imageGrow to hold the grown regions
    imageGrow = zeros(imageRow, imageCol);
    maxValue = 255;
%Grow from seedpoints
    imageGrow = RegionGrowIterator(image, imageGrow, thresh, seed1x, seed1y, maxValue);
    imageGrow = RegionGrowIterator(image, imageGrow, thresh, seed2x, seed2y, maxValue);
    imageGrow = RegionGrowIterator(image, imageGrow, thresh, seed3x, seed3y, maxValue);
%Mark seed in original image
    image(seed1x, seed1y) = 0;
    image(seed2x, seed2y) = 0;
    image(seed3x, seed3y) = 0;
%Show image
    figure('name', 'Original');
    imshow(uint8(image));
    figure('name', 'Grown');
    imshow(uint8(imageGrow));
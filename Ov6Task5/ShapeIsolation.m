%Clear previous values and output
    clc
    clear
%Load image from "File.tiff"
    image = imread('C:\Users\stianbm\Documents\MATLAB\GrunVisDatOv6\task5-03.tiff');
%Extract information
    imageRow = size(image, 1);
    imageCol = size(image, 2);
%------------------------Grid removal--------------------------------------
%Canny edge detection, need greyscale image
    %grey = rgb2gray(image);
    imageRedCanny = edge(image(:,:,1), 'Canny', [0.2, 0.25]);%, 'both', 2);
    imageGreenCanny = edge(image(:,:,2), 'Canny', [0.2, 0.25]);
    imageBlueCanny = edge(image(:,:,3), 'Canny', [0.2, 0.25]);
    edges = zeros(imageRow, imageCol);
    for i=1:imageRow
        for j=1:imageCol
            if imageRedCanny(i,j) > 0 ||...
                    imageGreenCanny(i,j) > 0 ||...
                    imageBlueCanny(i,j) > 0
                edges(i,j) = 1;
            end
        end
    end
    %edges = edge(grey, 'Canny', [0.2, 0.25]);%, 'both', 2);
%Hough
    [H,theta,rho] = hough(edges);
%Find peaks in transform
    P = houghpeaks(H,200,'threshold',ceil(0.15*max(H(:))), 'NHoodSize', [1,1]);
%Find the lines from the peaks
    lines = houghlines(edges,theta,rho,P,'FillGap',500,'MinLength',1);
%Subtrackt lines from the edges image
    edgesRemoved = edges;
    for k = 1:length(lines)
        if abs(lines(k).theta) < 1 ||...
                (abs(lines(k).theta) < 91 && abs(lines(k).theta) > 89)
            for i=lines(k).point1(1)-1:lines(k).point2(1)+1
                for j=lines(k).point1(2)-1:lines(k).point2(2)+1
                    edgesRemoved(j,i) = 0;
                end%for
            end%for
        end%if
    end%for
%------------------------ShapeIsolation------------------------------------
%Remove noise by counting pixels
    imageNoiseFree = bwareaopen(edgesRemoved, 50);
%Flood fill
    imageFlood = imfill(imageNoiseFree, 'holes');
%Label with connected components, 8-connected
    imageLabel = bwlabel(imageFlood);
%------------------------ShapeRecognition----------------------------------
%Find centroid with regionprops
    STATS = regionprops(imageLabel, 'all');
    shapes = zeros(1,length(STATS));
%Show shapes in original image
    imageFinal = image;
    for i=1:imageRow
        for j=1:imageCol
            if imageLabel(i,j) ~= 0
                imageFinal(i,j,1) = 255;
                imageFinal(i,j,2) = 0;
                imageFinal(i,j,3) = 0;
            end
        end
    end
%Recognice shapes and mark the image
    figure;
    imshow(imageFinal);
    hold on
    shapeNames = strings(1, length(shapes));
    for i = 1 : length(STATS)
        areaBox = STATS(i).BoundingBox(3)*STATS(i).BoundingBox(4);
        if abs(STATS(i).BoundingBox(3) - STATS(i).BoundingBox(4)) < 10
            shapes(i) = shapes(i) + 1;
        end
        if STATS(i).Solidity > 0.9
            shapes(i) = shapes(i) + 1;
        end
        if STATS(i).Extent > 0.68
            shapes(i) = shapes(i) + 1;
        end
        if STATS(i).Eccentricity < 0.8
            shapes(i) = shapes(i) + 1;
        end
        if abs(STATS(i).Area - areaBox*0.5) < 100
            shapes(i) = 5; %Triangle - formula for area with some room for error
        end
        if (STATS(i).Area / STATS(i).Perimeter) > 18.5
            shapes(i) = 6; %Circle, because of high fill of BoundingBox
        end
        if STATS(i).Area < 3000
            shapes(i) = 2; %Star has low area
        end
        centroid = STATS(i).Centroid;
    %Print centroids with marker and record shape in list
        switch shapes(i)
            case 1
                plot(centroid(1),centroid(2),'w+');
                shapeNames(i) = 'Rectangle';
            case 2
                plot(centroid(1),centroid(2),'w*');
                shapeNames(i) = 'Star';
            case 3
                plot(centroid(1),centroid(2),'wS');
                shapeNames(i) = 'Uknown';
            case 4
                plot(centroid(1),centroid(2),'wX');
                shapeNames(i) = 'Hexagon';
            case 5
                plot(centroid(1),centroid(2),'w^');
                shapeNames(i) = 'Triangle';
            case 6
                plot(centroid(1),centroid(2),'wO');
                shapeNames(i) = 'Circle';
        end
    end
%Print output
disp(shapeNames);
for i=1:length(STATS)
    disp(STATS(i).Centroid(1));
    disp(STATS(i).Centroid(2));
end
%------------------------Print images--------------------------------------
%     figure('Name','Original');
%     imshow(image);
%     figure('Name','Edges');
%     imshow(edges);
    figure('Name','EdgesRemoved');
    imshow(edgesRemoved);
%     figure('Name','ImageNoiseFree');
%     imshow(imageNoiseFree);
%     figure('Name','ImageFinal');
%     imshow(imageFinal);
    figure('Name','ImageLabel');
    imshow(imageLabel);
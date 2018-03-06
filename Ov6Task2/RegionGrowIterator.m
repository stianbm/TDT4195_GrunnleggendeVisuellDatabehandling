function imageGrown = RegionGrowIterator(image, imageGrow, thresh, seedx, seedy, maxValue)
%Extract image information
    imageRow = size(image, 1);
    imageCol = size(image, 2);
%Use two arrays as the FIFO queues for x and y coordinates
    arrayX = [seedx];
    arrayY = [seedy];
    seedIntensity = image(seedx, seedy);
%While loop
    while ~isempty(arrayX)
        %Extract new candidate and update iterator
        currentX = arrayX(1);
        currentY = arrayY(1);
        arrayX = arrayX(2:end);
        arrayY = arrayY(2:end);
        %Threshold candidate
        if imageGrow(currentX, currentY) == 0 &&...
                abs(image(currentX(1), currentY(1)) - seedIntensity) < thresh
            imageGrow(currentX, currentY) = maxValue;
            %Get 8 more candidates (Moore)
            for j=currentX-1:currentX+1
                for k=currentY-1:currentY+1
                    if imageGrow(j, k) == 0 &&...
                            ~(j == currentX && k == currentY) &&... 
                            0 < j &&...
                            j <= imageRow &&...
                            0 < k &&...
                           k <= imageCol
                        %Append to arrays
                        arrayX = [arrayX, j];
                        arrayY = [arrayY, k];
                    end%If
                end%For k
            end%For j
        end%If
    end%While
    imageGrown = imageGrow;
end%func
function [centers, radii] = computeHoughTransform(img, radiiRange)
    % img = Image after edge detection
    % radiiRange = range of radii to compute Hough Transform
    minRad = radiiRange(1);maxRad = radiiRange(2);
    numPeaks = 3;centers = zeros(numPeaks, 2); radii = zeros(size(centers,1),1);
    
    numRow = 0;
    for rad = linspace(minRad, maxRad, 5)
        houghAccmlr = zeros(size(img));
        for x = 1 : size(img, 2)
            for y = 1 : size(img, 1)
                if (img(y,x))
                    for theta = linspace(0, 2 * pi, 360)
                        a = round(x + rad * cos(theta)); % Using formula a = x + rcos(theta)               
                        b = round(y + rad * sin(theta)); % Using formula b = y + rsin(theta)
                        if (a > 0 && a <= size(houghAccmlr, 2) && b > 0 && b <= size(houghAccmlr,1))
                            houghAccmlr(b,a) = houghAccmlr(b,a) + 1;
                        end
                    end
                end
            end
        end
        % Obtain centers and radii of peaks
        iCenters = findPeaks(houghAccmlr); 
        if (size(iCenters,1) > 0)
                iNumRow = numRow + size(iCenters,1);
                centers(numRow + 1:iNumRow,:) = iCenters;
                radii(numRow + 1:iNumRow) = rad;
                numRow = iNumRow;       
        end
    end
    %figure();
    %imshow(imadjust(mat2gray(houghAccmlr))); % diplay hough space
    centers = centers(1:numRow,:);
    radii = radii(1:numRow);
end


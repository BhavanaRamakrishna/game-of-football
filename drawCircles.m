function drawCircles(img, centers, radii)
    % Input: img - Original image; [centers, radii] - centers and radii of peaks detected
    figure();
    imshow(img);
    hold on;
    for i = 1 : size(centers, 1)
        rad = radii(i);
        xCenter = centers(i, 2);
        yCenter = centers(i, 1);
        theta = linspace(0, 2 * pi, 360);
        xx = xCenter + rad * cos(theta);
        yy = yCenter + rad * sin(theta);
        plot(xx, yy,'r', 'LineWidth', 2);
    end
end
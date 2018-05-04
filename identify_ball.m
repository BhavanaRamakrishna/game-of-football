function detected_image = identify_ball(frame)
   %use color thresholding to remove background
   blacknwhite = remove_background(frame);
   %edge detection
   image_edges = get_edges(blacknwhite);
   %threshold to perform hough transform is there is a ball in the screen
   threshold_pixel = 90;
   number_of_pixels = find(image_edges);
   min_radius = 28;
   max_radius = 28;
   if (size(number_of_pixels,1)>threshold_pixel)
        %perform hough transform to detect circle
        [centers, radii] = computeHoughTransform(image_edges, [min_radius, max_radius]);
        detected_image = drawCircles(frame, centers, radii);
   else
       %capture image frames that does not have the ball
       figure('visible', 'off'), imshow(frame), title('frame');
       axis tight;
       %gcf is used to get frame from current figure
       image = getframe(gcf);
       %convert frame to image
       detected_image = frame2im(image);
   end
   
end
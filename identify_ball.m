function [detected_image, count] = identify_ball(frame, pos, count)
   %use color thresholding to remove background
   blacknwhite = remove_background(frame,100,255,0,80,0,80);
   %edge detection
   image_edges = get_edges(blacknwhite);
   %threshold to perform hough transform is there is a ball in the screen
   threshold_pixel = 90;
   number_of_pixels = find(image_edges);
   min_radius = 30;
   max_radius = 30;
   if (size(number_of_pixels,1)>threshold_pixel)
        %perform hough transform to detect circle
        [centers, radii] = computeHoughTransform(image_edges, [min_radius, max_radius]);
        [detected_image,count] = drawCircles(frame, centers, radii, pos, count);
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
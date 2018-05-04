function blacknwhite = remove_background(frame)
    %mark background as black
    %obtain pixels that have the same color as the ball
    %obtain red, green and blue channels
    red = frame(:,:,1);
    green = frame(:,:,2);
    blue = frame(:,:,3);
    %define minimum and maximum threshold to detect RED pixels 
    minred = 100;
    maxred = 255;
    mingreen = 0;
    maxgreen = 100;
    minblue = 0;
    maxblue = 100;
    %obtain red pixels
    blacknwhite =  (frame(:,:,1) >= minred ) & (frame(:,:,1) <= maxred) & ...
        (frame(:,:,2) >= mingreen ) & (frame(:,:,2) <= maxgreen) & ...
        (frame(:,:,3) >= minblue ) & (frame(:,:,3) <= maxblue);
end
function blacknwhite = remove_background(frame, minred, maxred, mingreen, maxgreen, minblue,maxblue)
    %mark background as black
    %obtain pixels that have the same color as the ball
    %obtain red pixels
    blacknwhite =  (frame(:,:,1) >= minred ) & (frame(:,:,1) <= maxred) & ...
        (frame(:,:,2) >= mingreen ) & (frame(:,:,2) <= maxgreen) & ...
        (frame(:,:,3) >= minblue ) & (frame(:,:,3) <= maxblue);
end
function pos = identify_goal(frame)
   %use color thresholding to remove background
   blacknwhite = remove_background(frame,0,90,100,255,0,150);
   [row, col] = find(blacknwhite);
   pos = horzcat(row,col);
end

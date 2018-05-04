function centers = findPeaks(houghAccmlr)
    % Input - hough accumlator
    % Output - centers(a,b) of peaks
    aPeaks = []; bPeaks = [];
    threshold = 0.9 * max(max(houghAccmlr));
    [maxb, maxa] = max(houghAccmlr);
    for i = 1:size(maxb, 2)
       if maxb(i) > threshold
           bPeaks(end + 1) = i;
           aPeaks(end + 1) = maxa(i);
       end
    end
    if(size(aPeaks, 1) > 0) 
        centers(:,1)= aPeaks;
        centers(:,2)= bPeaks;
    end
end


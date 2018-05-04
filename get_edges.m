function image_edges = get_edges(blacknwhite)
    %1X3 mask to obtain x derivative
    kernel_x  = [-1,0,1];
    image_row = size(blacknwhite,1);
    image_col = size(blacknwhite,2);
    kernel_row = 1;
    kernel_col = 3;
    row = 1;
    col = round(kernel_col/2);
    dx = double(zeros(image_row,image_col));
    %filtering with 1X3 mask
    for i=row:image_row-row+1
        for j=col:image_col-col+1
            sum = 0;
            for ii=1:kernel_row
                for jj=1:kernel_col
                    sum = sum + kernel_x(ii,jj)*blacknwhite(i-row+ii,j-col+jj);
                end
            end
            dx(i,j) = sum;
        end
    end

    %3X1 mask to obtain derivative of y
    kernel_y  = [-1;0; 1];
    kernel_row = 3;
    kernel_col = 1;
    row = round(kernel_row/2);
    col = 1;
    dy = double(zeros(image_row,image_col));
    %smoothening with 3X1 mask
    for i=row:image_row-row+1
        for j=col:image_col-col+1
            sum = 0;
            for ii=1:kernel_row
                for jj=1:kernel_col
                    sum = sum + kernel_y(ii,jj)*blacknwhite(i-row+ii,j-col+jj);
                end
            end
            dy(i,j) = sum;
        end
    end

    %vector magnitude
    vector = dx.^2 + dy.^2;
    image_edges = sqrt(vector);
end
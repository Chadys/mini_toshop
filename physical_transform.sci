function new_img = tiling(img, piece_size, gap_size)
    [img_l,img_c,c] = size(img)
    new_img=uint8(zeros(img_l, img_c, c));
    i=1; j=1;
    col=0;
    row=0;
    m=1;n=1;
    while ( i < img_l)
        while(m+i+row < img_l & n+j+col < img_c)
                new_img(m+i:m+i+row,n+j:n+j+col,:) = matrix(img(i:i+row,j:j+col,:),row+1,col+1,c);
              
                m=ceil(rand(1)*gap_size(1));
                n=ceil(rand(1)*gap_size(2));
                col=ceil(rand(1)*piece_size(2));
                row=ceil(rand(1)*piece_size(1));
            j=j+col;       
        end
        i=i+row;
        j=1;
    end
endfunction
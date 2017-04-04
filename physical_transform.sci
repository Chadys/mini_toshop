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


function newimg = glassy(img, brush_size)
    [x,y,c] = size(img)

    newimg=zeros([x-brush_size(1),y-brush_size(2),c]);

    for i=1:x-brush_size(1)
        for j=1:y-brush_size(2)
            brush_area=img(i:i+brush_size(1)-1,j:j+brush_size(2)-1,:);
            ii=ceil(rand(1)*brush_size(1));
            jj=ceil(rand(1)*brush_size(2));
            newimg(i,j,:)=matrix(brush_area(ii,jj,:),1,3);
        end
    end
endfunction


function new_img = mosaic(img, piece_size)
    [x,y,c] = size(img)
    new_img = []
    for i = 1:piece_size(1):floor(x/piece_size(1))*piece_size(1)
        for j = 1:piece_size(2):floor(y/piece_size(2))*piece_size(2)
            sq = img(i:min(i+piece_size(1)-1,x),j:min(j+piece_size(2)-1,y),:)
            sq = repmat(mean(mean(double(sq),1),2),piece_size)
            if new_img == [] then
                sq = matrix(sq, piece_size(1)*piece_size(2),c)
            end
            new_img(i:min(i+piece_size(1)-1,x),j:min(j+piece_size(2)-1,y),:) = sq
        end
    end
    new_img = uint8(new_img);
endfunction


function newimg = oil_painting(img, brush_size)
    [x,y,c] = size(img)

    newimg=zeros([x-brush_size(1),y-brush_size(2),c]);

    for i=1:x-brush_size(1)
        for j=1:y-brush_size(2)
            for k=1:c
                brush_area=img(i:i+brush_size(1)-1,j:j+brush_size(2)-1,k);
                histo=uint8(zeros(1,256));
                for b=1:brush_size(1)*brush_size(2)
                    value = uint16(brush_area(b))+1
                    histo(value)=histo(value)+1;
                end
                [maxvalue,pos]=max(histo);
                newimg(i,j,k)=pos(2)-1;
            end
        end
    end
    newimg = uint8(newimg)
endfunction


function newimg = noisify(img, noise_type, noise_factor)
    //noise_factor is optional
    if ~exists("noise_factor","local") then
        noise_factor = 0.3
    end
    //noise_type is optional
    if ~exists("noise_type","local") then
        noise_type = 1
    end
    //noise_factor 1 = bruit de perlin
    //noise_factor 2 = poivre&sel

    [x,y,c] = size(img)
    newimg = im2double(img)

    if noise_type == 1 then
        flt=noise_factor*rand(x, y, "normal")
        for k=1:c
            newimg(:,:,k) = 1.0/noise_factor*(newimg(:,:,k).*flt)
        end
    else
        noises = rand(x,y,c);
        newimg(noises<noise_factor/2) = 0;
        newimg((noises>=noise_factor/2)&(noises<noise_factor)) = 255;
    end
    newimg = im2uint8(newimg)
endfunction


function newimg = halftoning(img)
    [x,y,c] = size(img)
    original = im2double(img(:,:,:))
    newimg = zeros(x,y,c)
    chances = rand(x,y,c)
    newimg(original>chances) = 255;
    newimg = uint8(newimg)
endfunction


function newimg=halftoning2(img)
    //taken and adapted from IPT3:1.0 source code
    [x,y,c]=size(img);
    
    img=im2double(img);
    newimg=zeros(x,y);
    for i=1:x
        for j=1:y
            for k=1:c
                if img(i,j,k)>0.5 then
                    newimg(i,j,k)=1;
                end
            end
            overdue=img(i,j,:)-newimg(i,j,:);
            if j<y then
                img(i,j+1,:)=img(i,j+1,:)+overdue./2;
            end
            if i<x & j>1 then
                img(i+1, j-1,:)=img(i+1,j-1,:)+overdue./6;
            end
            if i<x  then
                img(i+1,j,:)=img(i+1,j,:)+overdue./4;
            end
        end
    end    
endfunction


function newimg=swirl(img, r_degree)
    //r_degree is optional
    if ~exists("r_degree","local") then
        r_degree = %pi/80
    end

    [x,y]=size(img);
    
    img=im2double(img);
    midx = x/2
    midy = y/2 
    for i=1:x
        for j=1:y
            ii = i-midx
            jj = j-midy
            [radius, theta] = cart2pol(ii, jj)
            distance = dist([i j], [midx midy])
            [new_i, new_j] = pol2cart(theta + r_degree*distance * radius, radius)
            new_i = ceil(midx + new_i)
            new_j = ceil(midx + new_j)
            if ~(new_i > 0 & new_i <= x)
                new_i = i
            end
            if ~(new_j > 0 & new_j <= y)
                new_j = j
            end
            newimg(i,j,:) = matrix(img(new_i, new_j,:),1,3)
        end
    end
    newimg = im2uint8(newimg)
endfunction


function newimg=sphere(img)
    [x,y]=size(img);
    
    img=im2double(img);
    midx = x/2
    midy = y/2 

    for i=1:x
        for j=1:y
            ii = i-midx
            jj = j-midy
            [radius, theta] = cart2pol(ii, jj)

            new_radius = radius^2/(max(midx, midy));

            [new_i, new_j] = pol2cart(theta, new_radius)
            new_i = ceil(midx + new_i)
            new_j = ceil(midx + new_j)
            if ~(new_i > 0 & new_i <= x)
                new_i = 1
            end
            if ~(new_j > 0 & new_j <= y)
                new_j = 1
            end
            newimg(i,j,:) = matrix(img(new_i, new_j,:),1,3)
        end
    end
    newimg = im2uint8(newimg)
endfunction


function newimg=time_warp(img, warp_factor)
    //warp_factor is optional
    if ~exists("warp_factor","local") then
        warp_factor = 10
    end
    [x,y]=size(img);
    
    img=im2double(img);
    midx = x/2
    midy = y/2 

    for i=1:x
        for j=1:y
            ii = i-midx
            jj = j-midy
            [radius, theta] = cart2pol(ii, jj)

            new_radius = sqrt(radius) * warp_factor

            [new_i, new_j] = pol2cart(theta, new_radius)
            new_i = ceil(midx + new_i)
            new_j = ceil(midx + new_j)
            if ~(new_i > 0 & new_i <= x)
                new_i = 1
            end
            if ~(new_j > 0 & new_j <= y)
                new_j = 1
            end
            newimg(i,j,:) = matrix(img(new_i, new_j,:),1,3)
        end
    end
    newimg = im2uint8(newimg)
endfunction


function newimg=water(img, wave_factor)
    //wave_factor is optional
    if ~exists("wave_factor","local") then
        wave_factor = %pi/80
    end
    [x,y]=size(img);
    
    img=im2double(img);
    midx = x/2
    midy = y/2 

    for i=1:x
        for j=1:y
            ii = i-midx
            jj = j-midy

            new_i = ceil(i+(double(wave_factor) * sin(2.0 * %pi * j / 128.0)));
            new_j = ceil(j+(double(wave_factor) * cos(2.0 * %pi * i / 128.0)));

            if ~(new_i > 0 & new_i <= x)
                new_i = 1
            end
            if ~(new_j > 0 & new_j <= y)
                new_j = 1
            end
            newimg(i,j,:) = matrix(img(new_i, new_j,:),1,3)
        end
    end
    newimg = im2uint8(newimg)
endfunction
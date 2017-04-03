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
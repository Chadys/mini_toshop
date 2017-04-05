function new_img = tiling(img, piece_size, gap_size)
    // effet de déplacement random de sous-blocs de l'image
    // param : piece_size = taille max d'une piece
    // vecteur de deux int
    // param : piece_size = taille max dde l'espacement entre deux pieces
    // vecteur de deux int

    if ~exists("piece_size","local") then
        piece_size = [5 6]
    end
    if ~exists("gap_size","local") then
        gap_size = [2 3]
    end

    [img_l,img_c,c] = size(img)
    new_img=uint8(zeros(img_l, img_c, c));
    i=1; j=1;
    col=ceil(rand(1)*piece_size(2));
    row=ceil(rand(1)*piece_size(1));
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
    // effet comme à travers un verre texturé
    // param : brush_size = taille des traits
    // vecteur contenant longueur et largeur

    if ~exists("brush_size","local") then
        brush_size = [3 3]
    end

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
    // effet de pixellisation
    // param : piece_size = taille des "pixel"
    // vecteur contenant longueur et largeur

    if ~exists("piece_size","local") then
        piece_size = [6 6]
    end

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
    // effet comme une peinture
    // param : brush_size = taille des traits
    // vecteur contenant longueur et largeur

    if ~exists("brush_size","local") then
        brush_size = [7 7]
    end

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
    // ajoute du bruit à une image
    // param : noise_type = type de bruit voulu
    // 1 ou 2
    //1:bruit de perlin
    //2:poivre&sel
    // param : noise_factor = coef de bruit
    // uniquement utilisé pour le poivre&sel
    // petit float, entre 0 et 0.5

    if ~exists("noise_type","local") then
        noise_type = 1
    end
    if ~exists("noise_factor","local") then
        noise_factor = 0.02
    end

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
        newimg((noises>=noise_factor/2)&(noises<noise_factor)) = 1;
    end
    newimg = im2uint8(newimg)
endfunction


function newimg = halftoning(img)
    // Méthode de halftoning (n'utiliser que des pixels noir ou blanc
    // pour obtenir des variances de gris)
    // par random (plus l'intensité du pixel de base est forte,
    // plus il a de chances d'être mis en noir)

    [x,y,c] = size(img)
    original = im2double(img(:,:,:))
    newimg = zeros(x,y,c)
    chances = rand(x,y,c)
    newimg(original>chances) = 255;
    newimg = uint8(newimg)
endfunction


function newimg=halftoning2(img)
    // Méthode de halftoning (n'utiliser que des pixels noir ou blanc
    // par renforcement

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
    // Fait tourbillonner l'image
    // param : r_degree = degré de rotation
    // %pi sur grande valeur
    // à tester avec %pi/2, %pi/3, %pi/7, %pi/80 et %pi/10000

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


function newimg=fisheye(img)
    // effet fish-eye

    [x,y]=size(img);
    
    img=im2double(img);
    midx = x/2
    midy = y/2 

    for i=1:x
        for j=1:y
            ii = i-midx
            jj = j-midy
            [radius, theta] = cart2pol(ii, jj)

            new_radius = radius^2/max(midx, midy);

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


function newimg=time_warp(img)
    // comme si le milieu de l'image l'aspirait

    [x,y]=size(img);
    
    img=im2double(img);
    midx = x/2
    midy = y/2 

    for i=1:x
        for j=1:y
            ii = i-midx
            jj = j-midy
            [radius, theta] = cart2pol(ii, jj)

            new_radius = sqrt(radius) * sqrt(max(midx, midy))

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


function newimg=wave(img, wave_factor, v_distord, h_distord)
    // effet de vague sur l'image
    // param : wave_factor = coef de déformation
    // entre 0 et 100
    // param : v_distord = déformation verticale
    // booléen
    // param : h_distord = déformation horizontale
    // booléen

    if ~exists("wave_factor","local") then
        wave_factor = 10
    end
    if ~exists("v_distord","local") then
        v_distord = %t
    end
    if ~exists("h_distord","local") then
        h_distord = %t
    end

    [x,y]=size(img);
    
    img=im2double(img);
    midx = x/2
    midy = y/2 

    for i=1:x
        for j=1:y
            ii = i-midx
            jj = j-midy

            if h_distord then
                new_i = ceil(i+(double(wave_factor) * sin(2.0 * %pi * j / 128.0)));
            else
                new_i = i
            end
            if v_distord then
                new_j = ceil(j+(double(wave_factor) * cos(2.0 * %pi * i / 128.0)));
            else
                new_j = j
            end

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
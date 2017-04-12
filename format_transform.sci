function [zoomed_im] = zoom(original_im, zoom_factor)
	// zoom
	// param : zoom_factor = coef de zoom

  	if ~exists("zoom_factor","local") then
    	zoom_factor = 2
  	end

	[x,y,c] = size(original_im);

	for i=1 : x
		for j=1 : y
			for mod_x = ((zoom_factor *(i -1))+1) : (((zoom_factor *(i -1))+1) + zoom_factor)
				for mod_y = ((zoom_factor *(j -1))+1) : (((zoom_factor *(j -1))+1) + zoom_factor)
					zoomed_im(mod_x,mod_y,:) = matrix(original_im(i,j,:),1,c)
				end
			end
		end
	end
endfunction


function newimg = flip(img, flip_type)
	// renverser une image
	// param : flip_type = sens du renversement
	// entre 1 et 3
	//1:vertical
	//2:horizontal
	//3:les deux
  	if ~exists("flip_type","local") then
    	flip_type = 3
  	end
	[x,y,c] = size(img)

	// vertical flip
	if flip_type == 1 then
		for i = 1 : x
			for j = 1 : y/2+1
				newimg(i,j,:) = matrix(img(i,y-j+1,:),1,c)
				newimg(i,y-j+1,:) = matrix(img(i,j,:),1,c)
			end
		end
	// horizontal flip
	elseif flip_type == 2 then
		for i = 1 : x/2+1
			for j = 1 : y
				newimg(i,j,:) = matrix(img(x-i+1,j,:),1,c)
				newimg(x-i+1,j,:) = matrix(img(i,j,:),1,c)
			end 
		end
	// both flips
	else
		for i=1:x
			for j=1:y/2+1
				newimg(i,j,:)=matrix(img(x-i+1, y-j+1,:),1,3)
				newimg(x-i+1, y-j+1,:)=matrix(img(i,j,:),1,3)
			end
		end
	end
endfunction


function newimg=rotation(img, deg)
    // applique une rotation a une image, ne change pas la taille de l'image
    // param: deg = angle de rotation en degrée
    // -360 à 360

    if ~exists("deg","local") then
        deg = 90
    end

	img = img(1:min(size(img,1),size(img,2)),1:min(size(img,1),size(img,2)),:)
    [x,y]=size(img);
    
    deg = deg2rad(deg)
    img=im2double(img);
    midx = x/2
    midy = y/2 
    for i=1:x
        for j=1:y
            ii = i-midx
            jj = j-midy
            [radius, theta] = cart2pol(ii, jj)
            [new_i, new_j] = pol2cart(theta + deg, radius)
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
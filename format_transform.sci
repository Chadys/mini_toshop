function [zoomed_im] = zoom(original_im, zoom_factor)
	//zoom_factor is optional
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

function new_img = flip(img, flip_type)
	//flip_type is optional
  	if ~exists("flip_type","local") then
    	flip_type = 2
  	end
	[x,y,c] = size(img)

	// vertical flip
	if flip_type == 0 then
		for i = 1 : x
			for j = 1 : y/2+1
				new_img(i,j,:) = matrix(img(i,y-j+1,:),1,c)
				new_img(i,y-j+1,:) = matrix(img(i,j,:),1,c)
			end
		end
	// horizontal flip
	elseif flip_type == 1 then
		for i = 1 : x/2+1
			for j = 1 : y
				new_img(i,j,:) = matrix(img(x-i+1,j,:),1,c)
				new_img(x-i+1,j,:) = matrix(img(i,j,:),1,c)
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
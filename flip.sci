function new_img = flip(img, flip_type)
	//flip_type is optional
  	if ~exists("flip_type","local") then
    	flip_type = 2
  	end
	[lines,col,c] = size(img)

	// vertical flip
	if flip_type == 0 then
		for i = 1 : lines
			for j = 1 : col/2+1
				new_img(i,j,:) = matrix(img(i,col-j+1,:),1,c)
				new_img(i,col-j+1,:) = matrix(img(i,j,:),1,c)
			end
		end
	// horizontal flip
	elseif flip_type == 1 then
		for i = 1 : lines/2+1
			for j = 1 : col
				new_img(i,j,:) = matrix(img(lines-i+1,j,:),1,c)
				new_img(lines-i+1,j,:) = matrix(img(i,j,:),1,c)
			end 
		end
	// both flips
	else
		for i=1:lines
			for j=1:col/2+1
				newimg(i,j,:)=matrix(img(x-i+1, y-j+1,:),1,3)
				newimg(x-i+1, y-j+1,:)=matrix(img(i,j,:),1,3)
			end
		end
	end
endfunction
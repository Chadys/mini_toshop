function newimg = rvb2nb(img)
	r = img(:,:,1)
	g = img(:,:,2)
	b = img(:,:,3)
	newimg = imlincomb(0.299,r,0.587,g,0.114,b)
endfunction


function newimg = negative(img)
	newimg = 255-img
endfunction


function newimg = brightness(img, shift)
	[x,y,c] = size(img)

	for i=1 : x
		for j=1 : y
			for k=1:c
				new_value = double(img(i,j,k))+shift
				if new_value < 0 then
					newimg(i,j,k) = 0
				elseif new_value > 255 then
					newimg(i,j,k) = 255
				else
					newimg(i,j,k) = new_value
				end
			end
		end
	end
	newimg = uint8(newimg)
endfunction


function newimg = exposure(img, shift)
	[x,y,c] = size(img)

	for i=1 : x
		for j=1 : y
			for k=1:c
				new_value = double(img(i,j,k))*shift
				if new_value < 0 then
					newimg(i,j,k) = 0
				elseif new_value > 255 then
					newimg(i,j,k) = 255
				else
					newimg(i,j,k) = new_value
				end
			end
		end
	end
	newimg = uint8(newimg)
endfunction


function newimg = glitch(img, glitchiness)
	[x,y,c] = size(img)

	for i=1 : x
		for j=1 : y
			newimg(i,j,:) = matrix(img(i,j,:)*glitchiness,1,c)
		end
	end
endfunction


function newimg = seuillage(img, seuil)
	//seuil is optional
  	if ~exists("seuil","local") then
    	seuil = 255/2
  	end
	[x,y,c] = size(img)

	for i=1 : x
		for j=1 : y
			maxi = max(img(i,j,:))
			if maxi > seuil then
				newimg(i,j) = 255
			else
				newimg(i,j) = 0
			end
		end
	end
endfunction


function [R,G,B] = rgb_channels(img)
	blank = uint8(zeros(img(:,:,1)))
	R = img(:,:,1)
	R(:,:,2) = blank
	R(:,:,3) = blank
	G = blank
	G(:,:,2) = img(:,:,2)
	G(:,:,3) = blank
	B = blank
	B(:,:,2) = blank
	B(:,:,3) = img(:,:,3)
endfunction


function newimg = bit_reduce(img, nbits)
    if nbits > 8 then
        error('nbits must not be greater than 8!');
    end
	[x,y,c] = size(img)

	gray_lvl = 2^nbits
	pas = 256/gray_lvl
	values_dist = floor(256/(gray_lvl-1))
	for i = 1:gray_lvl
		values(i) = (i-1)*values_dist
	end

	for i=1:x
	    for j=1:y
	    	for k = 1:c
	    		newimg(i,j,k) = min(values(floor(double(img(i,j,k))/pas)+1),255)
	    	end
	    end
	end
	newimg = uint8(newimg)
endfunction


function new_img = linear_extension(img)
    [x,y,c] = size(img)
    for k=1:c
    	min_value(k) = min(img(:,:,k))
    	max_value(k) = max(img(:,:,k))
    end
    for ng = 1 : 256
    	for k = 1 : c
    		LUT(ng,k) = (255*double(ng-1-min_value(k)))/double(max_value(k)-min_value(k))
    	end
    end
    for i = 1:x
    	for j = 1:y
    		for k = 1:c
	    		new_img(i,j,k) = LUT(uint16(img(i,j,k))+1)
	    	end
    	end
    end
    new_img = uint8(new_img)
endfunction


function new_img = histo_equalizer(img)
    [x,y,c] = size(img)
    
	histo=uint32(zeros(1,256));
    for i = 1:x
    	for j = 1:y
    		pixel_intensity = round(mean(double(img(i,j,:))+1
    		histo(pixel_intensity) = histo(pixel_intensity)+1
    	end
    end
    for i = 1:256
    	histo_cumul(i) = sum(histo(1:i))
    end
    for i = 1:x
    	for j = 1:y
    		for k = 1:c
    			new_img(i,j,k) = (uint32(histo_cumul(uint16(img(i,j,k))+1))*255)/(x*y)
    		end
    	end
    end
    new_img = uint8(new_img)
endfunction
function newimg = rvb2ng(img)
	r = img(:,:,1)
	g = img(:,:,2)
	b = img(:,:,3)
	newimg = imlincomb(0.299,r,0.587,g,0.114,b)
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


function newimg = black_and_white(img)
	[x,y,c] = size(img)

	for i=1 : x
		for j=1 : y
			maxi = max(img(i,j,:))
			if maxi > 255/2 then
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
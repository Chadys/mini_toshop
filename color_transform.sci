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
				new_value = uint32(img(i,j,k))+shift
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
				new_value = uint32(img(i,j,k))*shift
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
	        	newimg(i,j,k)=pos-1;
	    	end
		end
	end
	newimg = uint8(newimg)
endfunction
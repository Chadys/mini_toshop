function newimg = rvb2ng(img)
	r = img(:,:,1)
	g = img(:,:,2)
	b = img(:,:,3)
	newimg = imlincomb(0.299,r,0.587,g,0.114,b)
endfunction
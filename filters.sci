function flt = moyenneur(T)
	flt = ones(T,T) * 1/9
endfunction


function flt = sharpener(T)
	//T is optional
  	if ~exists("T","local") then
    	T=3
  	end

	flt = zeros(T,T)
	middle = floor(T/2)
	flt(middle, middle) = 2
	flt = flt - moyenneur(T)
endfunction


function flt = gaussien(T, sigma)
	//sigma is optional
  	if ~exists("sigma","local") then
    	sigma = 1.4
  	end

	indices = -floor(T/2) : floor(T/2);
	[x y] = meshgrid(indices, indices);
	flt = exp(-((x.^2 + y.^2) / (2*sigma^2)))/(2*%pi*sigma^2)
endfunction


function [D,G,H,B] = sobel(T)
	D =  -floor(T/2) : floor(T/2)
	for i = 2 : T
		D($+1,:) = D(1,:)*(min(abs(i-1), abs(i-T))+1)
	end
	G = -D
	B = D'
	H = -B
endfunction


function flt = laplacien(T)
	//T is optional
  	if ~exists("T","local") then
    	T = 8
  	end
  	if T == 4 then
  		flt = [1 1 1 ; 1 -8 1 ; 1 1 1]
  	else
  		flt = [0 1 0 ; 1 -4 1 ; 0 1 0]
  	end
endfunction




function new_img = apply_filter(img, flt, border_mode)

	//border_mode is optional
  	if ~exists("border_mode","local") then
    	border_mode = 3
  	end
	//border_mode 1 = border to 0
	//border_mode 2 = partial convolution
	//border_mode 3 = mirror border used

	[x,y,c] = size(img)
	img = im2double(img)
	[flt_x,flt_y] = size(flt)
	border_l_limit = floor(flt_x/2)
	border_c_limit = floor(flt_y/2)

	for i=1 : x
		for j=1 : y
			//if border
			if border_mode == 1 & (i <= border_l_limit | j <= border_c_limit |...
							i > x-border_l_limit | j > y-border_c_limit) then
				//put to zero border pixels
				new_img(i,j,:) = [0 0 0]
			else
				new_val = hypermat([1 1 3])
				for ii = -border_l_limit : border_l_limit
					for jj = -border_c_limit : border_c_limit
						//if outside border
						if i+ii < 1 | i+ii > x | j+jj < 1 | j+jj > y then
							//mirror border
							if border_mode == 3 then
								I = max(i+ii, 1)
								I = min(I, x)
								J = max(j+jj, 1)
								J = min(J, y)
								new_val = new_val + img(I, J,:)*flt(border_l_limit+1+ii, border_c_limit+1+jj)
							end
						else
							new_val = new_val + img(i+ii, j+jj,:)*flt(border_l_limit+1+ii, border_c_limit+1+jj)
						end
					end
				end
				new_img(i, j,:) = matrix(new_val,1,c)
			end
		end
	end
	new_img = im2uint8(new_img)
endfunction


function new_img = apply_median_filter(img, filter_size, border_mode)

	//filter_size is optional
  	if ~exists("filter_size","local") then
    	filter_size = [3 3]
  	end

	//border_mode is optional
  	if ~exists("border_mode","local") then
    	border_mode = 3
  	end
	//border_mode 1 = border to 0
	//border_mode 2 = partial convolution
	//border_mode 3 = mirror border used

	[x,y, c] = size(img)
	border_l_limit = floor(filter_size(1)/2)
	border_c_limit = floor(filter_size(2)/2)

	for i=1 : x
		for j=1 : y
			//if border
			if border_mode == 1 & (i <= border_l_limit | j <= border_c_limit |...
							i > x-border_l_limit | j > y-border_c_limit) then
				//put to zero border pixels
				new_img(i,j,:) = [0 0 0]
			else
				bas = max(i-border_l_limit, 1)
				haut = min(i+border_l_limit, x)
				gauche = max(j-border_c_limit,1)
				droite = min(j+border_c_limit, y)
				voisins = img(bas:haut, gauche:droite,:)
				//mirror border
				if border_mode == 3 then
					for k=i-border_l_limit:1
						voisins(border_l_limit+1,:,:)=voisins(1,:,:)
					end
					for k=j-border_c_limit:1
						voisins(:,border_c_limit+1,:)=voisins(:,1,:)
					end
					for k=x+1:i+border_l_limit
						voisins(border_l_limit+1,:,:)=voisins(border_l_limit,:,:)
					end
					for k=y+1:j+border_c_limit
						voisins(:,border_c_limit+1,:)=voisins(:,border_c_limit,:)
					end
				end
				n_y = length(voisins(:,:,1))
				voisins = gsort(matrix(voisins, 1, n_y, c))
				new_img(i,j,:) = matrix(voisins(:,n_y/2,:),1,c)
			end
		end
	end
	new_img = uint8(new_img)
endfunction


function new_img = outlining(img, filter_size, border_mode)

	//filter_size is optional
  	if ~exists("filter_size","local") then
    	filter_size = 3
  	end
	//border_mode is optional
  	if ~exists("border_mode","local") then
    	border_mode = 3
  	end
	//border_mode 1 = border to 0
	//border_mode 2 = partial convolution
	//border_mode 3 = mirror border used

	[x,y,c] = size(img)

	[D,G,H,B] = sobel(filter_size)
	d = apply_filter(img, D,border_mode)
	g = apply_filter(img, G,border_mode)
	h = apply_filter(img, H,border_mode)
	b = apply_filter(img, B,border_mode)

	for i=1 : x
		for j=1 : y
			new_values = uint32(d(i,j,:))+g(i,j,:)+h(i,j,:)+b(i,j,:)
			new_img(i,j,:) = min(matrix(new_values,1,3),resize_matrix(255,1,c,"",255))
		end
	end
	new_img = uint8(new_img)
endfunction
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

	indices = -floor(N/2) : floor(N/2);
	[x y] = meshgrid(indices, indices);
	flt = exp(-((x.^2 + y.^2) / (2*sigma^2)))/(2*%pi*sigma^2)
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
								y = i+ii
								z = j+jj
								if i+ii < 1 | i+ii > x then
									y = 1
								end
								if j+jj < 1 | j+jj > x then
									z = 1
								end
								new_val = new_val + img(y, z,:)*flt(border_l_limit+1+ii, border_c_limit+1+jj)
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
endfunction


function new_img = apply_median_filter(img, filter_l, filter_c, border_mode)

	//filter_l is optional
  	if ~exists("filter_l","local") then
    	filter_l = 3
  	end
	//filter_c is optional
  	if ~exists("filter_c","local") then
    	filter_c = 3
  	end

	//border_mode is optional
  	if ~exists("border_mode","local") then
    	border_mode = 3
  	end
	//border_mode 1 = border to 0
	//border_mode 2 = partial convolution
	//border_mode 3 = mirror border used

	[x,y, c] = size(img)
	border_l_limit = floor(filter_l/2)
	border_c_limit = floor(filter_c/2)

	for i=1 : x
		for j=1 : y
			//if border
			if border_mode == 1 & (i <= border_l_limit | j <= border_c_limit |...
							i > x-border_l_limit | j > y-border_c_limit) then
				//put to zero border pixels
				new_img(i,j,:) = [0 0 0]
			else
				bas = i-border_l_limit
				haut = i+border_l_limit
				gauche = j-border_c_limit
				droite = j+border_c_limit
				if gauche < 1 then ; gauche = 1 ; end
				if bas < 1 then ; bas = 1 ; end
				if haut > x then ; haut = x ; end
				if droite > y then ; droite = y ; end
				voisins = img(bas:haut, gauche:droite,:)
				//mirror border
				if border_mode == 3 then
					for k=i-border_l_limit:1
						voisins(border_l_limit+1,:,:)=voisins(1,:,:)
					end
					for k=j-border_c_limit:1
						voisins(:,border_c_limit+1,:)=voisins(:,1,:)
					end
					for k=x:i+border_l_limit
						voisins(border_l_limit+1,:,:)=voisins(border_l_limit,:,:)
					end
					for k=y:j+border_c_limit
						voisins(:,border_c_limit+1,:)=voisins(:,border_c_limit,:)
					end
				end
				n_y = length(voisins(:,:,1))
				voisins = gsort(matrix(voisins, 1, n_y, c))
				new_img(i,j,:) = matrix(voisins(:,n_y/2,:),1,c)
			end
		end
	end

endfunction
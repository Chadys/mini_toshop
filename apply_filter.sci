function new_img = apply_filter(img, flt, border_mode)

	//border_mode is optional
  	if ~exists("border_mode","local") then
    	border_mode = 3
  	end
	//border_mode 1 = border to 0
	//border_mode 2 = partial convolution
	//border_mode 3 = mirror border used

	[lines,col,c] = size(img)
	img = im2double(img)
	[flt_lines,flt_col] = size(flt)
	border_l_limit = floor(flt_lines/2)
	border_c_limit = floor(flt_col/2)

	for i=1 : lines
		for j=1 : col
			//if border
			if border_mode == 1 & (i <= border_l_limit | j <= border_c_limit |...
							i > lines-border_l_limit | j > col-border_c_limit) then
				//put to zero border pixels
				new_img(i,j,:) = [0 0 0]
			else
				new_val = hypermat([1 1 3])
				for ii = -border_l_limit : border_l_limit
					for jj = -border_c_limit : border_c_limit
						//if outside border
						if i+ii < 1 | i+ii > lines | j+jj < 1 | j+jj > col then
							//mirror border
							if border_mode == 3 then
								y = i+ii
								z = j+jj
								if i+ii < 1 | i+ii > lines then
									y = 1
								end
								if j+jj < 1 | j+jj > lines then
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

	[lines,col, c] = size(img)
	border_l_limit = floor(filter_l/2)
	border_c_limit = floor(filter_c/2)

	for i=1 : lines
		for j=1 : col
			//if border
			if border_mode == 1 & (i <= border_l_limit | j <= border_c_limit |...
							i > lines-border_l_limit | j > col-border_c_limit) then
				//put to zero border pixels
				new_img(i,j,:) = [0 0 0]
			else
				bas = i-border_l_limit
				haut = i+border_l_limit
				gauche = j-border_c_limit
				droite = j+border_c_limit
				if gauche < 1 then ; gauche = 1 ; end
				if bas < 1 then ; bas = 1 ; end
				if haut > lines then ; haut = lines ; end
				if droite > col then ; droite = col ; end
				voisins = img(bas:haut, gauche:droite,:)
				//mirror border
				if border_mode == 3 then
					for k=i-border_l_limit:1
						voisins(border_l_limit+1,:,:)=voisins(1,:,:)
					end
					for k=j-border_c_limit:1
						voisins(:,border_c_limit+1,:)=voisins(:,1,:)
					end
					for k=lines:i+border_l_limit
						voisins(border_l_limit+1,:,:)=voisins(border_l_limit,:,:)
					end
					for k=col:j+border_c_limit
						voisins(:,border_c_limit+1,:)=voisins(:,border_c_limit,:)
					end
				end
				n_col = length(voisins(:,:,1))
				voisins = gsort(matrix(voisins, 1, n_col, c))
				new_img(i,j,:) = matrix(voisins(:,n_col/2,:),1,c)
			end
		end
	end

endfunction
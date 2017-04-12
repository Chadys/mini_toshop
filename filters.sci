function flt = moyenneur(T)
	// filtre flou uniforme
	// param : T = taille du filtre
	// nombre impaire (idéalement entre 3 et 15)

  	if ~exists("T","local") then
    	T=3
  	end
    if ~modulo(T,2) | T<3 | T>15 then
        error('T must be an odd number between 3 and 15!');
    end

	flt = ones(T,T) * 1/9
endfunction


function flt = sharpener(T)
	// filtre accentuation des détails
	// param : T = taille du filtre
	// nombre impaire (idéalement entre 3 et 15)

  	if ~exists("T","local") then
    	T=3
  	end
    if ~modulo(T,2) | T<3 | T>15 then
        error('T must be an odd number between 3 and 15!');
    end

	flt = zeros(T,T)
	middle = floor(T/2)
	flt(middle, middle) = 2
	flt = flt - moyenneur(T)
endfunction


function flt = gaussien(T, sigma)
	// filtre flou pondéré
	// param : T = taille du filtre
	// nombre impaire (idéalement entre 3 et 15)
	// param : sigma = coef de gauss
	// petit double ~entre 0 et 3?

  	if ~exists("sigma","local") then
    	sigma = 1.4
  	end
  	if ~exists("T","local") then
    	T=3
  	end
    if ~modulo(T,2) | T<3 | T>15 then
        error('T must be an odd number between 3 and 15!');
    end

	indices = -floor(T/2) : floor(T/2);
	[x y] = meshgrid(indices, indices);
	flt = exp(-((x.^2 + y.^2) / (2*sigma^2)))/(2*%pi*sigma^2)
endfunction


function [D,G,H,B] = sobel(T)
	// filtre de détection de contour
	// renvoit les 4 filtres de sobel possibles
	// param : T = taille du filtre
	// nombre impaire (idéalement entre 3 et 15)

  	if ~exists("T","local") then
    	T=3
  	end
    if ~modulo(T,2) | T<3 | T>15 then
        error('T must be an odd number between 3 and 15!');
    end

	D =  -floor(T/2) : floor(T/2)
	for i = 2 : T
		D($+1,:) = D(1,:)*(min(abs(i-1), abs(i-T))+1)
	end
	G = -D
	B = D'
	H = -B
endfunction


function flt = laplacien(T)
	// meilleur filtre de détection de contour
	// param : T = taille du filtre
	// 4 ou 8

  	if ~exists("T","local") then
    	T = 8
  	end
    if T<>4 & T<>8 then
        error('T must be 4 or 8!');
    end

  	if T == 4 then
  		flt = [0 1 0 ; 1 -4 1 ; 0 1 0]
  	else
  		flt = [1 1 1 ; 1 -8 1 ; 1 1 1]
  	end
endfunction




function new_img = convolute(img, flt, border_mode)
	// application d'un filtre de convolution
	// param : flt = filtre
	// matrice à deux dimensions
	// param : border_mode = mode de gestion de la bordure
	// entre 1 et 3
	//border_mode 1 = border to 0
	//border_mode 2 = partial convolution
	//border_mode 3 = mirror border used

  	if ~exists("border_mode","local") then
    	border_mode = 3
  	end

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


function new_img = median_filter(img, filter_size, border_mode)
	// application d'un filtre median
	// param : filter_size = taille du filtre
	// vector à deux entrées ([3 3] ou [5 7] par exemple)
	// idéalement le même chiffre et nombre impaire entre 3 et 15
	// param : border_mode = mode de gestion de la bordure
	// entre 1 et 3
	//border_mode 1 = border to 0
	//border_mode 2 = partial convolution
	//border_mode 3 = mirror border used

  	if ~exists("filter_size","local") then
    	filter_size = [3 3]
  	end
  	if ~exists("border_mode","local") then
    	border_mode = 3
  	end

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
				haut = max(i-border_l_limit, 1)
				bas = min(i+border_l_limit, x)
				gauche = max(j-border_c_limit,1)
				droite = min(j+border_c_limit, y)
				voisins = img(haut:bas, gauche:droite,:)
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


function new_img = despeckle(img, filter_size, border_mode)
	// application d'un filtre de débruitage
	// param : filter_size = taille du filtre
	// vector à deux entrées ([3 3] par exemple)
	// idéalement le même chiffre et nombre impaire entre 3 et 15
	// param : border_mode = mode de gestion de la bordure
	// entre 1 et 2
	//border_mode 1 = border to 0
	//border_mode 2 = partial convolution

  	if ~exists("filter_size","local") then
    	filter_size = [3 3]
  	end
  	if ~exists("border_mode","local") then
    	border_mode = 2
  	end

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
				haut = max(i-border_l_limit, 1)
				bas = min(i+border_l_limit, x)
				gauche = max(j-border_c_limit,1)
				droite = min(j+border_c_limit, y)
				tmp = 1
				for ii = haut:bas
					for jj = gauche:droite
						//if not center pixel
						if ii <> i | jj <> j then
							voisins(tmp,:) = double(matrix(img(ii,jj,:),1,c))
							tmp = tmp+1
						end
					end
				end
				color_intensity = mean(voisins,2)
				ecart_type = stdev(color_intensity)
				if abs(mean(color_intensity) - double(img(i,j))) > ecart_type then
					new_img(i,j,:) = mean(voisins,1)
				else
					new_img(i,j,:) = matrix(img(i,j,:),1,c)
				end
			end
		end
	end
	new_img = uint8(new_img)
endfunction


function new_img = outlining(img, filter_size, border_mode)
	// application  des quatre filtres de sobel
	// param : filter_size = taille du filtre
	// nombre impaire (idéalement entre 3 et 15)
	// param : border_mode = mode de gestion de la bordure
	// entre 1 et 3
	//border_mode 1 = border to 0
	//border_mode 2 = partial convolution
	//border_mode 3 = mirror border used

  	if ~exists("filter_size","local") then
    	filter_size = 3
  	end
  	if ~exists("border_mode","local") then
    	border_mode = 3
  	end

	[x,y,c] = size(img)

	[D,G,H,B] = sobel(filter_size)
	d = convolute(img, D,border_mode)
	g = convolute(img, G,border_mode)
	h = convolute(img, H,border_mode)
	b = convolute(img, B,border_mode)

	for i=1 : x
		for j=1 : y
			new_values = uint32(d(i,j,:))+g(i,j,:)+h(i,j,:)+b(i,j,:)
			new_img(i,j,:) = min(matrix(new_values,1,3),resize_matrix(255,1,c,"",255))
		end
	end
	new_img = uint8(new_img)
endfunction
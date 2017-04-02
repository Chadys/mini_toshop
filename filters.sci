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
	[lines col] = meshgrid(indices, indices);
	flt = exp(-((lines.^2 + col.^2) / (2*sigma^2)))/(2*%pi*sigma^2)
endfunction
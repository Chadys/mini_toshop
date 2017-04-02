function [zoomed_im] = zoom(original_im, zoom_factor)

	[line,col,c] = size(original_im);

	for i=1 : line
		for j=1 : col
			for mod_x = ((zoom_factor *(i -1))+1) : (((zoom_factor *(i -1))+1) + zoom_factor)
				for mod_y = ((zoom_factor *(j -1))+1) : (((zoom_factor *(j -1))+1) + zoom_factor)
					zoomed_im(mod_x,mod_y,:) = matrix(original_im(i,j,:),1,c)
				end
			end
		end
	end
endfunction
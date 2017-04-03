rand('seed',getdate('s'))

function [r, theta] = cart2pol(x, y)
	r = sqrt(x.^2 + y.^2);
	theta = atan(y,x);
endfunction


function [x,y] = pol2cart(theta,r)
	x = r*cos(theta);
	y = r*sin(theta);
endfunction;


function d = dist(x, y)
	d = sqrt((x(1)-y(1))^2+(x(2)-y(2))^2)
endfunction;

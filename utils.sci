rand('seed',getdate('s'))

function [r, theta] = cart2pol(x, y)
	// conversion coordonnées cartésiennes à polaire
	// param : x = abcisse
	// param : y = ordonnée

	r = sqrt(x.^2 + y.^2);
	theta = atan(y,x);
endfunction


function [x,y] = pol2cart(theta,r)
	// conversion coordonnées polaires à cartésiennes
	// param : theta = angle
	// param : r = rayon
	
	x = r*cos(theta);
	y = r*sin(theta);
endfunction;


function d = dist(x, y)
	// distance euclidienne entre deux points
	// param : x = vecteur coordonnées du point 1
	// param : x = vecteur coordonnées du point 2

	d = sqrt((x(1)-y(1))^2+(x(2)-y(2))^2)
endfunction;


function [rad]=deg2rad(deg)
	// converti un angle en degré en radian
	// param : deg = angle en degré
    rad=(deg/180)*%pi;
endfunction
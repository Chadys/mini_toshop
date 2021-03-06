function make_demo(img, file_path)
	// créer et enregistre des images d'exemple
	// d'utilisation de toutes les fonctions de modification
	// param: file_path = string, endroit où les image seront enregistrées
	// /!\ Attention, si image grande, très lent /!\

	imwrite(img, file_path+"/00.png")
	nb_img = rvb2nb(img)
	imwrite(nb_img, file_path+"/01.png")
	[R,V,B] = rgb_channels(img)
	imwrite(negative(img), file_path+"/02.png")
	imwrite(negative(nb_img), file_path+"/03.png")
	imwrite(R, file_path+"/04.png")
	imwrite(V, file_path+"/05.png")
	imwrite(B, file_path+"/06.png")
	imwrite(color_blend(img,"yellow",1), file_path+"/07.png")
	imwrite(bit_reduce(nb_img,3), file_path+"/10.png")
	imwrite(bit_reduce(img,2), file_path+"/11.png")
	imwrite(seuillage(nb_img, 128), file_path+"/12.png")
	imwrite(seuillage(img, 128), file_path+"/13.png")
	imwrite(glitch(img, 5), file_path+"/14.png")
	imwrite(glitch(nb_img, 5), file_path+"/15.png")
	imwrite(brightness(img, 80), file_path+"/16.png")
	imwrite(brightness(img, -80), file_path+"/17.png")
	imwrite(exposure(img, 2), file_path+"/18.png")
	dark = exposure(img, 0.5)
	imwrite(dark, file_path+"/19.png")
	imwrite(histo_equalizer(dark), file_path+"/08.png")
	imwrite(linear_extension(dark), file_path+"/09.png")

	imwrite(rotation(img,150), file_path+"/20.png")
	imwrite(zoom(img, 0.5), file_path+"/21.png")
	imwrite(zoom(img, 2), file_path+"/22.png")
	imwrite(flip(img, 3), file_path+"/23.png")

	imwrite(tiling(img, [5 6], [2 3]), file_path+"/24.png")
	imwrite(glassy(img, [3 3]), file_path+"/25.png")
	imwrite(mosaic(img, [15 16]), file_path+"/26.png")
	imwrite(mosaic(img, [6 8]), file_path+"/27.png")
	imwrite(oil_painting(img, [7 7]), file_path+"/28.png")
	imwrite(oil_painting(nb_img, [7 7]), file_path+"/29.png")
	imwrite(noisify(img,1), file_path+"/30.png")
	imwrite(noisify(nb_img,2,0.02), file_path+"/31.png")
	noise_img = noisify(img, 2, 0.03)
	imwrite(noisify(img,2, 0.3), file_path+"/32.png")
	imwrite(halftoning(img), file_path+"/33.png")
	imwrite(halftoning(nb_img), file_path+"/34.png")
	imwrite(halftoning2(img), file_path+"/35.png")
	imwrite(halftoning2(nb_img), file_path+"/36.png")
	imwrite(swirl(img, %pi/2), file_path+"/37.png")
	imwrite(swirl(img, %pi/3), file_path+"/38.png")
	imwrite(swirl(img, %pi/7), file_path+"/39.png")
	imwrite(swirl(img, %pi/80), file_path+"/40.png")
	imwrite(swirl(img, %pi/10000), file_path+"/41.png")
	imwrite(fisheye(img), file_path+"/42.png")
	imwrite(time_warp(img), file_path+"/43.png")
	imwrite(wave(img, 20, %t, %t), file_path+"/44.png")
	imwrite(wave(img, 20, %f, %t), file_path+"/45.png")
	imwrite(wave(img, 20, %t, %f), file_path+"/46.png")

	moyen = convolute(img, moyenneur(3))
	imwrite(moyen, file_path+"/47.png")
	imwrite(convolute(noise_img, moyenneur(3)), file_path+"/48.png")
	imwrite(convolute(img, moyenneur(5)), file_path+"/49.png")
	imwrite(convolute(img, gaussien(3)), file_path+"/50.png")
	imwrite(convolute(img, gaussien(5)), file_path+"/51.png")
	imwrite(convolute(noise_img, gaussien(5)), file_path+"/52.png")
	imwrite(convolute(img, gaussien(7)), file_path+"/53.png")
	imwrite(median_filter(img, [3 3]), file_path+"/54.png")
	imwrite(median_filter(noise_img, [3 3]), file_path+"/55.png")
	imwrite(median_filter(img, [5 5]), file_path+"/56.png")
	imwrite(despeckle(img, [3 3]), file_path+"/57.png")
	imwrite(despeckle(noise_img, [3 3]), file_path+"/58.png")
	imwrite(despeckle(img, [5 5]), file_path+"/59.png")
	imwrite(despeckle(noise_img, [5 5]), file_path+"/60.png")
	imwrite(convolute(img, sharpener(3)), file_path+"/61.png")
	imwrite(convolute(moyen, sharpener(3)), file_path+"/62.png")
	imwrite(convolute(img, laplacien(4)), file_path+"/63.png")
	imwrite(convolute(img, laplacien(8)), file_path+"/64.png")
	[D,G,H,B] = sobel(3)
	imwrite(convolute(img, D), file_path+"/65.png")
	imwrite(outlining(img, 3), file_path+"/66.png")
	imwrite(outlining(img, 5), file_path+"/67.png")
	imwrite(median_filter(noisify(img,1), [3 3]), file_path+"/68.png")

endfunction
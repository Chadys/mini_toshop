//Supported file formats (Outside of function else it doesnt work)
supported_formats = ["*.jp*g","JPG/JPEG format";"*.png","PNG format";"*.gif","GIF format"];

//LOAD FUNCTION
function [base_image,current_s_image,current_ns_image] = my_load(sup_formats)
	base_image = imread(uigetfile(sup_formats,"$HOME","Load picture"));
	current_s_image = base_image;
	current_ns_image = base_image;
	imshow(current_ns_image);
endfunction

//SAVE FUNCTION
function [] = my_save(sup_formats,picture)
	imwrite(picture , uiputfile(sup_formats,"$HOME","Save picture"));
endfunction

//UPDATE FILTER
//function [] = updatelistbox (filterlist , filterframe , slider_item1 , slider_item2 , slider_item3, edit_item1)
function [new_slider_item1, new_slider_item1_text,new_slider_item1_desc,new_slider_item2, new_slider_item2_text,new_slider_item2_desc,new_slider_item3, new_slider_item3_text,new_slider_item3_desc,new_slider_item4, new_slider_item4_text,new_slider_item4_desc] = updatelistbox (filterlist , filterframe , slider_item1, slider_item1_text,slider_item1_desc ,slider_item2, slider_item2_text, slider_item2_desc,slider_item3, slider_item3_text,slider_item3_desc,slider_item4, slider_item4_text,slider_item4_desc)
  	disp(filterlist.Value);

  	if ~exists("new_slider_item1","local") then
  			new_slider_item1 = uicontrol(filterframe , "style" , "slider");
  			new_slider_item2 = uicontrol(filterframe , "style" , "slider");
  			new_slider_item3 = uicontrol(filterframe , "style" , "slider");
  			new_slider_item4 = uicontrol(filterframe , "style" , "slider");
		end

  	if ~exists("new_slider_item1_text","local") then
			new_slider_item1_text = uicontrol(filterframe, "style", "edit");
			new_slider_item2_text = uicontrol(filterframe, "style", "edit");
			new_slider_item3_text = uicontrol(filterframe, "style", "edit");
			new_slider_item4_text = uicontrol(filterframe, "style", "edit");
  		end

  	if ~exists("new_slider_item1_desc","local") then
		new_slider_item1_desc = uicontrol(filterframe, "style", "text");
		new_slider_item2_desc = uicontrol(filterframe, "style", "text");
		new_slider_item3_desc = uicontrol(filterframe, "style", "text");
		new_slider_item4_desc = uicontrol(filterframe, "style", "text");
  	end

if filterlist.Value < 5
	clf(filterframe,"reset");
end

if filterlist.Value == 5
	clf(filterframe,"reset");
	   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "brightness shift", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "80";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String;";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = -255;
	 	new_slider_item1.max = 255;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.value = 80;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(int32(new_slider_item1.value));"
end
if filterlist.Value == 6
	clf(filterframe,"reset");
	   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "bexposure shift", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "2";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = (new_slider_item1_text.String)";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 1000;
	 	new_slider_item1.SliderStep = [0.1 0.1];
	 	new_slider_item1.value = 2;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(double(new_slider_item1.value))"
end
if filterlist.Value == 7
	clf(filterframe,"reset");
	   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Glitch factor", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "5";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = (new_slider_item1_text.String)";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 1000;
	 	new_slider_item1.SliderStep = [0.1 1];
	 	new_slider_item1.value = 5;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(double(new_slider_item1.value))"
end
if filterlist.Value == 8
	clf(filterframe,"reset");
	   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Treshold", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "127";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String)";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 255;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.value = 127;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
end
if filterlist.Value == 9
	clf(filterframe,"reset");
	   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "bits", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "3";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String)";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 1;
	 	new_slider_item1.max = 8;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.value = 3;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
end
if filterlist.Value == 10
		//RED
   		clf(filterframe,"reset");
   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "RED", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "255";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 255;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.Value = 255;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
	 	//GREEN
	 	 new_slider_item2_desc = uicontrol(filterframe, "style", "text", ...
	 						    "string", "GREEN", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 40 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item2_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item2_text.Position = [110 40 50 30];
	 	new_slider_item2_text.String = "255";
	 	new_slider_item2_text.Callback = "new_slider_item2.Value = new_slider_item2_text.String";
   		new_slider_item2 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item2.Position = [0 40 100 30];
	 	new_slider_item2.min = 0;
	 	new_slider_item2.max = 255;
	 	new_slider_item2.SliderStep = [1 1];
	 	new_slider_item2.Value = 255;
	 	new_slider_item2.Callback = "new_slider_item2_text.String = string(uint8(new_slider_item2.value))"
	 	//BLUE
   		new_slider_item3_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "BLUE", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 80 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item3_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item3_text.Position = [110 80 50 30];
	 	new_slider_item3_text.String = "0";
	 	new_slider_item3_text.Callback = "new_slider_item3.Value = new_slider_item3_text.String";
   		new_slider_item3 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item3.Position = [0 80 100 30];
	 	new_slider_item3.min = 0;
	 	new_slider_item3.max = 255;
	 	new_slider_item3.SliderStep = [1 1];
	 	new_slider_item3.Value = 0;
	 	new_slider_item3.Callback = "new_slider_item3_text.String = string(uint8(new_slider_item3.value))"
	 	//COEF
	 	new_slider_item4_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Coef (intensity)", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 120 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item4_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item4_text.Position = [110 120 50 30];
	 	new_slider_item4_text.String = "1";
	 	new_slider_item4_text.Callback = "new_slider_item4.Value = (new_slider_item4_text.String)";
   		new_slider_item4 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item4.Position = [0 120 100 30];
	 	new_slider_item4.min = 0;
	 	new_slider_item4.max = 100;
	 	new_slider_item4.SliderStep = [0.1 1];
	 	new_slider_item4.Value = 1;
	 	new_slider_item4.Callback = "new_slider_item4_text.String = string(double(new_slider_item4.value))"
	end
	if filterlist.Value == 11
		clf(filterframe,"reset");
		   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
		 						    "string", "Zoom_factor", ...
		 						    "fontsize", 12, ...
		 						    "fontweight", "bold", ...
		 						    "fontangle", "italic", ...
		 						    "position", [170 0 150 30], ...
		 						    "HorizontalAlignment", "center");
		 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
		 	new_slider_item1_text.Position = [110 0 50 30];
		 	new_slider_item1_text.String = "2";
		 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
	   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
		 	new_slider_item1.Position = [0 0 100 30];
		 	new_slider_item1.min = 1;
		 	new_slider_item1.max = 10;
		 	new_slider_item1.SliderStep = [1 1];
		 	new_slider_item1.value = 2;
		 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
	end
	if filterlist.Value == 12
		clf(filterframe,"reset");
		   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
		 						    "string", "[Vertical,Horizontal,Both]", ...
		 						    "fontsize", 12, ...
		 						    "fontweight", "bold", ...
		 						    "fontangle", "italic", ...
		 						    "position", [170 0 150 30], ...
		 						    "HorizontalAlignment", "center");
		 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
		 	new_slider_item1_text.Position = [110 0 50 30];
		 	new_slider_item1_text.String = "2";
		 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
	   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
		 	new_slider_item1.Position = [0 0 100 30];
		 	new_slider_item1.min = 1;
		 	new_slider_item1.max = 3;
		 	new_slider_item1.SliderStep = [1 1];
		 	new_slider_item1.value = 2;
		 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
	end
		if filterlist.Value == 13
			//Piece size X
   		clf(filterframe,"reset");
   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Piece size X", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "5";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 255;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.Value = 5;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
	 	//Piece size Y
	 	 new_slider_item2_desc = uicontrol(filterframe, "style", "text", ...
	 						    "string", "Piece size Y", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 40 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item2_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item2_text.Position = [110 40 50 30];
	 	new_slider_item2_text.String = "6";
	 	new_slider_item2_text.Callback = "new_slider_item2.Value = new_slider_item2_text.String";
   		new_slider_item2 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item2.Position = [0 40 100 30];
	 	new_slider_item2.min = 0;
	 	new_slider_item2.max = 255;
	 	new_slider_item2.SliderStep = [1 1];
	 	new_slider_item2.Value = 6;
	 	new_slider_item2.Callback = "new_slider_item2_text.String = string(uint8(new_slider_item2.value))"
	 	//Gap size X
   		new_slider_item3_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Gap size X", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 80 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item3_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item3_text.Position = [110 80 50 30];
	 	new_slider_item3_text.String = "2";
	 	new_slider_item3_text.Callback = "new_slider_item3.Value = new_slider_item3_text.String";
   		new_slider_item3 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item3.Position = [0 80 100 30];
	 	new_slider_item3.min = 0;
	 	new_slider_item3.max = 255;
	 	new_slider_item3.SliderStep = [1 1];
	 	new_slider_item3.Value = 2;
	 	new_slider_item3.Callback = "new_slider_item3_text.String = string(uint8(new_slider_item3.value))"
	 	//Gap size Y
	 	new_slider_item4_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Gap size Y", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 120 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item4_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item4_text.Position = [110 120 50 30];
	 	new_slider_item4_text.String = "3";
	 	new_slider_item4_text.Callback = "new_slider_item4.Value = (new_slider_item4_text.String)";
   		new_slider_item4 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item4.Position = [0 120 100 30];
	 	new_slider_item4.min = 0;
	 	new_slider_item4.max = 255;
	 	new_slider_item4.SliderStep = [1 1];
	 	new_slider_item4.Value = 3;
	 	new_slider_item4.Callback = "new_slider_item4_text.String = string(uint8(new_slider_item4.value))"
	end
 //  	if filterlist.Value == 1 then
 //  		clf(filterframe,"reset");
 //  		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	// 						    "string", "Hello im slider 1", ...
	// 						    "fontsize", 12, ...
	// 						    "fontweight", "bold", ...
	// 						    "fontangle", "italic", ...
	// 						    "position", [170 0 150 30], ...
	// 						    "HorizontalAlignment", "center");
	// 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	// 	new_slider_item1_text.Position = [110 0 50 30];
	// 	new_slider_item1_text.Callback = "new_slider_item1.Value = uint8(new_slider_item1_text.String)";
 //  		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	// 	new_slider_item1.Position = [0 0 100 30];
	// 	new_slider_item1.min = 1;
	// 	new_slider_item1.max = 4;
	// 	new_slider_item1.SliderStep = [1 1];
	// 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
	// elseif filterlist.Value == 2 then 
	// 	clf(filterframe,"reset");
	// 	 new_slider_item2_desc = uicontrol(filterframe, "style", "text", ...
	// 						    "string", "Hello im slider 2", ...
	// 						    "fontsize", 12, ...
	// 						    "fontweight", "bold", ...
	// 						    "fontangle", "italic", ...
	// 						    "position", [170 40 150 30], ...
	// 						    "HorizontalAlignment", "center");
	// 	new_slider_item2_text = uicontrol(filterframe, "style", "edit");
	// 	new_slider_item2_text.Position = [110 40 50 30];
	// 	new_slider_item2_text.Callback = "new_slider_item2.Value = uint8(new_slider_item2_text.String)";
 //  		new_slider_item2 = uicontrol(filterframe , "style" , "slider");
	// 	new_slider_item2.Position = [0 40 100 30];
	// 	new_slider_item2.min = 1;
	// 	new_slider_item2.max = 4;
	// 	new_slider_item2.SliderStep = [1 1];
	// 	new_slider_item2.Callback = "new_slider_item2_text.String = string(uint8(new_slider_item2.value))"
	// 	end
	// 	  	if filterlist.Value == 3 then
 //  		clf(filterframe,"reset");
 //  		new_slider_item3_desc =uicontrol(filterframe, "style", "text", ...
	// 						    "string", "Hello im slider 3", ...
	// 						    "fontsize", 12, ...
	// 						    "fontweight", "bold", ...
	// 						    "fontangle", "italic", ...
	// 						    "position", [170 80 150 30], ...
	// 						    "HorizontalAlignment", "center");
	// 	new_slider_item3_text = uicontrol(filterframe, "style", "edit");
	// 	new_slider_item3_text.Position = [110 80 50 30];
	// 	new_slider_item3_text.Callback = "new_slider_item3.Value = uint8(new_slider_item3_text.String)";
 //  		new_slider_item3 = uicontrol(filterframe , "style" , "slider");
	// 	new_slider_item3.Position = [0 80 100 30];
	// 	new_slider_item3.min = 1;
	// 	new_slider_item3.max = 4;
	// 	new_slider_item3.SliderStep = [1 1];
	// 	new_slider_item3.Callback = "new_slider_item3_text.String = string(uint8(new_slider_item3.value))"
	// end
endfunction

//	1: rvb2nb(img)
//	2: negative(img)
//	3: linear_extension(img)
//	4: histo_equalizer(img)
//	5: brightness(img, shift(80) -inf + inf)
//	6: exposure(img, shift(2) 0 + inf)
//	7: glitch(img, glitchiness(5) 0 + inf)
//	8: seuillage(img, treshold(255/2)0 255)
//	9: bit_reduce(img, nbits(3)1 à 8)
//	10: color_blend(img, color(yellow),coef(1)0 100)
//	11: zoom (im , zoom_factor(2)2 + inf)
//	12: flip (im , flip_type(2) 0 1 2)
//	13: tiling
//APPLY CALLBACK
function [new_current_s_image, new_current_ns_image] = my_applycall(filterlist, current_ns_image, slider_item1 ,slider_item1_text,slider_item1_desc , slider_item2 ,slider_item2_text,slider_item2_desc , slider_item3 ,slider_item3_text,slider_item3_desc , slider_item4 ,slider_item4_text,slider_item4_desc)
	if filterlist.Value ==1 then
		new_current_s_image = rvb2nb(current_ns_image);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==2 then
		new_current_s_image = negative(current_ns_image);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==3 then
		new_current_s_image = linear_extension(current_ns_image);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==4 then
		new_current_s_image = histo_equalizer(current_ns_image);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==5 then
		new_current_s_image = brightness(current_ns_image , slider_item1.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==6 then
		new_current_s_image = exposure(current_ns_image , slider_item1.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==7 then
		new_current_s_image = glitch(current_ns_image , slider_item1.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==8 then
		new_current_s_image = seuillage(current_ns_image , slider_item1.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==9 then
		new_current_s_image = bit_reduceit(current_ns_image , slider_item1.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==10 then
		new_current_s_image = color_blend(current_ns_image ,[slider_item1.value slider_item2.value slider_item3.value], slider_item4.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==11 then
		new_current_s_image = zoom(current_ns_image , slider_item1.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==12 then
		new_current_s_image = flip(current_ns_image , slider_item1.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==13 then
		new_current_s_image = tiling(current_ns_image , [slider_item1.value slider_item2.value], [slider_item3.value slider_item4.value]);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
endfunction

//SHOW CALLBACK
function my_showcall (current_s_image)
  	imshow(current_s_image);
endfunction

//REFRESH CALLBACK
function [ new_current_s_image , new_current_ns_image] = my_refreshcall (base_image)
  	new_current_s_image = base_image;
  	new_current_ns_image = base_image;
  	imshow(new_current_ns_image);
endfunction

//MAIN UI
//function [fig_item] = my_gui()


//Figure init
hmain = scf();
fig_item = figure(0 , "position" , [0 0 400 600]);

//Picture section
picture_sect_item = uimenu(fig_item,'label', 'Picture');

//File subsection
file_sub_item = uimenu(picture_sect_item,'label','File');

load_file_item = uimenu(file_sub_item ,'label', 'Load picture', 'callback',"[base_image,current_s_image,current_ns_image] = my_load(supported_formats)");
save_file_item = uimenu(file_sub_item ,'label', 'Save picture', 'callback',"my_save(supported_formats,picture)");

//Title
our_title = uicontrol(fig_item, "style", "text", ...
    "string", "☼ Minitoshop ☼", ...
    "fontsize", 12, ...
    "fontweight", "bold", ...
    "fontangle", "italic", ...
    "position", [150 570 100 30], ...
    "HorizontalAlignment", "center", ...
    "ForegroundColor", [1 0.7 0]);


//Filter spe frame
filterframe = uicontrol(fig_item,"style","frame");
filterframe.Position = [0 125 400 300];
//Slider 1 text desc
slider_item1_desc = uicontrol(filterframe, "style", "text", ...
    "string", "Hello im slider 1", ...
    "fontsize", 12, ...
    "fontweight", "bold", ...
    "fontangle", "italic", ...
    "position", [170 0 150 30], ...
    "HorizontalAlignment", "center");
//Slider 1 text
slider_item1_text = uicontrol(filterframe, "style", "edit");
slider_item1_text.Position = [110 0 50 30];
slider_item1_text.Callback = "slider_item1.Value = slider_item1_text.String";
//Slider 1
slider_item1 = uicontrol(filterframe , "style" , "slider");
slider_item1.Position = [0 0 100 30];
slider_item1.min = 1;
slider_item1.max = 4;
slider_item1.SliderStep = [1 1];
slider_item1.Callback = "slider_item1_text.String = string(uint8(slider_item1.value))"
//Slider 2 text desc
slider_item2_desc = uicontrol(filterframe, "style", "text", ...
    "string", "Hello im slider 2", ...
    "fontsize", 12, ...
    "fontweight", "bold", ...
    "fontangle", "italic", ...
    "position", [170 40 150 30], ...
    "HorizontalAlignment", "center");
//Slider 2 text
slider_item2_text = uicontrol(filterframe, "style", "edit");
slider_item2_text.Position = [110 40 50 30];
slider_item2_text.Callback = "slider_item2.Value = slider_item2.value";

//Slider 2
slider_item2 = uicontrol(filterframe , "style" , "slider");
slider_item2.Position = [0 40 100 30];
slider_item2.min = 3;
slider_item2.max = 12;
slider_item2.SliderStep = [2 2];
slider_item2.Callback = "slider_item2_text.String = string(uint8(slider_item2.value))"
//Slider 3 text desc
slider_item3_desc = uicontrol(filterframe, "style", "text", ...
    "string", "Hello im slider 3", ...
    "fontsize", 12, ...
    "fontweight", "bold", ...
    "fontangle", "italic", ...
    "position", [170 80 150 30], ...
    "HorizontalAlignment", "center");
//Slider 3 text
slider_item3_text = uicontrol(filterframe, "style", "edit");
slider_item3_text.Position = [110 80 50 30];
slider_item3_text.Callback = "slider_item3.Value = slider_item3_text.String";

//Slider 3
slider_item3 = uicontrol(filterframe , "style" , "slider");
slider_item3.Position = [0 80 100 30];
slider_item3.min = 3;
slider_item3.max = 12;
slider_item3.SliderStep = [2 2];
slider_item3.Callback = "slider_item3_text.String = string(uint8(slider_item3.value))"
//Slider 4 text desc
slider_item4_desc = uicontrol(filterframe, "style", "text", ...
    "string", "Hello im slider 4", ...
    "fontsize", 12, ...
    "fontweight", "bold", ...
    "fontangle", "italic", ...
    "position", [170 120 150 30], ...
    "HorizontalAlignment", "center");
//Slider 4 text
slider_item4_text = uicontrol(filterframe, "style", "edit");
slider_item4_text.Position = [110 120 50 30];
slider_item4_text.Callback = "slider_item4.Value = slider_item4_text.String";

//Slider 4
slider_item4 = uicontrol(filterframe , "style" , "slider");
slider_item4.Position = [0 120 100 30];
slider_item4.min = 3;
slider_item4.max = 12;
slider_item4.SliderStep = [2 2];
slider_item4.Callback = "slider_item4_text.String = string(uint8(slider_item4.value))"

//Filter listbox
clf(filterframe);
filterlist=uicontrol(fig_item,"style","listbox");
filterlist.Position = [100 475 200 80];
filterlist.String = ["rvb2nb" "negative" "linear_extension" "histo_equalizer" "brightness" "exposure" "glitch" "seuillage" "bit_reduce" "color_blend" "zoom" "flip" "tiling"];
filterlist.Value = 1;
filterlist.BackgroundColor=[1 1 1];
filterlist.Callback = "[new_slider_item1,new_slider_item1_text,new_slider_item1_desc,new_slider_item2,new_slider_item2_text,new_slider_item2_desc,new_slider_item3,new_slider_item3_text,new_slider_item3_desc,new_slider_item4,new_slider_item4_text,new_slider_item4_desc] = updatelistbox(filterlist, filterframe , slider_item1, slider_item1_text, slider_item1_desc, slider_item2, slider_item2_text, slider_item2_desc, slider_item3, slider_item3_text, slider_item3_desc,slider_item4, slider_item4_text, slider_item4_desc)";

//Apply button
apply_button = uicontrol(fig_item, "style" , "pushbutton");
apply_button.String = "Apply";
apply_button.Position = [150 80 100 30];
//(filterlist , current_pic_saved, current_pic_non_saved, is_filter)
apply_button.Callback = "[current_s_image,current_ns_image] = my_applycall(filterlist,current_s_image,new_slider_item1, new_slider_item1_text, new_slider_item1_desc, new_slider_item2, new_slider_item2_text, new_slider_item2_desc, new_slider_item3, new_slider_item3_text, new_slider_item3_desc,new_slider_item4, new_slider_item4_text, new_slider_item4_desc)";

//Refresh button
refresh_button = uicontrol(fig_item, "style" , "pushbutton");
refresh_button.String = "Refresh";
refresh_button.Position = [50 40 100 30];
//(base_pic , current_pic_saved , current_pic_non_saved)
refresh_button.Callback = "[current_s_image,current_ns_image] = my_refreshcall(base_image);";


//Show button
undo_button = uicontrol(fig_item, "style" , "pushbutton");
undo_button.String = "Show";
undo_button.Position = [250 40 100 30];
undo_button.Callback = "my_showcall(current_s_image)";

//File operations picture will be the save load item can be changed if wanted

//endfunction

//  Convolute filters:
//	1: moyenneur (T(3)) impair 3 15
//	2: sharpener (T(3)) 
//	3: gaussien  (T(3), sigma(1.4) 0 db 3)
//	4: laplacien (T(8) 4 ou 8)
//
//	convolute border modes:
//	1: border to 0
//	2: partiel convolution
//	3: mirror border
//
//	1: rvb2nb(img)
//	2: negative(img)
//	3: linear_extension(img)
//	4: histo_equalizer(img)
//	5: brightness(img, shift(80) -inf + inf)
//	6: exposure(img, shift(2) 0 + inf)
//	7: glitch(img, glitchiness(5) 0 + inf)
//	8: seuillage(img, treshold(255/2)0 255)
//	9: bit_reduce(img, nbits(3)1 à 8)
//	10: color_blend(img, color(yellow),coef(1)0 100)
//	11: zoom (im , zoom_factor(2)2 + inf)
//	12: flip (im , flip_type(2) 0 1 2)
//	13: tiling

//Image de base
//Current image (saved state)
//Current image (non saved)
//Champ val numérique
//Button save
//Button refresh
//Button undo
//	13: convolute (im, flt ,border_mode(3))
//	14: median_filter(img, flt_size(3 3),border_mode(3))
//	15: despeckle(img, flt_size(3 3), border_mode(2)1 2)
//	16: outlining(img, flt_size(3), border_mode(3))
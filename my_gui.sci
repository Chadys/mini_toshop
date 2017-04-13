//Supported file formats (Outside of function else it doesnt work)
supported_formats = ["*.jp*g","JPG/JPEG format";"*.png","PNG format"];

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

//UPDATE COMMON FILTER
function [] = up_common(frame_list)
	disp(frame_list.Value);
endfunction
//UPDATE FILTER
//function [] = updatelistbox (filterlist , filterframe , slider_item1 , slider_item2 , slider_item3, edit_item1)
function [new_slider_item1, new_slider_item1_text,new_slider_item1_desc,new_slider_item2, new_slider_item2_text,new_slider_item2_desc,new_slider_item3, new_slider_item3_text,new_slider_item3_desc,new_slider_item4, new_slider_item4_text,new_slider_item4_desc, new_frame_list, new_frame_list_desc,new_frame_list2,new_frame_list2_desc] = updatelistbox (filterlist , filterframe)
  	disp(filterlist.Value);

	if ~exists("new_frame_list","local") then
		//Item list
  		new_frame_list = uicontrol(filterframe , "style" , "listbox");
  		//desc
  		new_frame_list_desc = uicontrol(filterframe, "style", "text");
  		//Item list 2
  		new_frame_list2 = uicontrol(filterframe , "style" , "listbox");
  		//desc
  		new_frame_list2_desc = uicontrol(filterframe, "style", "text");

	end

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

if filterlist.Value < 5 //rbv2nb , negative , histo equaliter, linear extension
	clf(filterframe,"reset");
end

if filterlist.Value == 5 //brightness
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
if filterlist.Value == 6 //exposure
	clf(filterframe,"reset");
	   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "exposure shift", ...
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
	 	new_slider_item1.max = 255;
	 	new_slider_item1.SliderStep = [0.1 0.1];
	 	new_slider_item1.value = 2;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(double(new_slider_item1.value))"
end
if filterlist.Value == 7 //glitch
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
if filterlist.Value == 8 //seuillage
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
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 255;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.value = 127;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
end
if filterlist.Value == 9 //bit_reduce
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
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 1;
	 	new_slider_item1.max = 8;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.value = 3;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
end
if filterlist.Value == 10 //colorblend
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
	if filterlist.Value == 11 //zoom
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
		 	new_slider_item1.min = 0.1;
		 	new_slider_item1.max = 10;
		 	new_slider_item1.SliderStep = [0.1 0.1];
		 	new_slider_item1.value = 2;
		 	new_slider_item1.Callback = "new_slider_item1_text.String = string(double(new_slider_item1.value))"
	end
	if filterlist.Value == 12 //Flip
		clf(filterframe,"reset");
  		//desc
  		new_frame_list_desc = uicontrol(filterframe, "style", "text", ...
		 						    "string", "Flip axe", ...
		 						    "fontsize", 12, ...
		 						    "fontweight", "bold", ...
		 						    "fontangle", "italic", ...
		 						    "position", [210 235 150 30], ...
		 						    "HorizontalAlignment", "center");
	 	//Item list
  		new_frame_list = uicontrol(filterframe , "style" , "listbox");
  		new_frame_list.position = [0 210 200 80];
  		new_frame_list.String = ["Vertical" "Horizontal" "Both"];
  		new_frame_list.Value = 3;
  		new_frame_list.BackgroundColor=[1 1 1];
  		new_frame_list.Callback = "up_common(new_frame_list)";
	end
		if filterlist.Value == 13 //Tiling
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
	if filterlist.Value == 14 then //glassy
				//Brush size X
   		clf(filterframe,"reset");
   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Brush size X", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "3";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 1000;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.Value = 3;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint16(new_slider_item1.value))"
	 	//Brush size Y
	 	 new_slider_item2_desc = uicontrol(filterframe, "style", "text", ...
	 						    "string", "Brush size Y", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 40 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item2_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item2_text.Position = [110 40 50 30];
	 	new_slider_item2_text.String = "3";
	 	new_slider_item2_text.Callback = "new_slider_item2.Value = new_slider_item2_text.String";
   		new_slider_item2 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item2.Position = [0 40 100 30];
	 	new_slider_item2.min = 0;
	 	new_slider_item2.max = 1000;
	 	new_slider_item2.SliderStep = [1 1];
	 	new_slider_item2.Value = 3;
	 	new_slider_item2.Callback = "new_slider_item2_text.String = string(uint16(new_slider_item2.value))"
 	end
 	if filterlist.Value == 15 then //mosaic
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
	 	new_slider_item1_text.String = "6";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 1000;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.Value = 6;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint16(new_slider_item1.value))"
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
	 	new_slider_item2.max = 1000;
	 	new_slider_item2.SliderStep = [1 1];
	 	new_slider_item2.Value = 6;
	 	new_slider_item2.Callback = "new_slider_item2_text.String = string(uint16(new_slider_item2.value))"
  	end
 	if filterlist.Value == 16 then //oil painting
		//Brush size X
   		clf(filterframe,"reset");
   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Brush size X", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "7";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 1000;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.Value = 7;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint16(new_slider_item1.value))"
	 	//Brush size Y
	 	 new_slider_item2_desc = uicontrol(filterframe, "style", "text", ...
	 						    "string", "Brush size Y", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 40 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item2_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item2_text.Position = [110 40 50 30];
	 	new_slider_item2_text.String = "7";
	 	new_slider_item2_text.Callback = "new_slider_item2.Value = new_slider_item2_text.String";
   		new_slider_item2 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item2.Position = [0 40 100 30];	
	 	new_slider_item2.min = 0;
	 	new_slider_item2.max = 1000;
	 	new_slider_item2.SliderStep = [1 1];
	 	new_slider_item2.Value = 7;
	 	new_slider_item2.Callback = "new_slider_item2_text.String = string(uint16(new_slider_item2.value))"
	 end
	 if filterlist.Value == 17 //noisify
	 	clf(filterframe,"reset");
  		//desc
  		new_frame_list_desc = uicontrol(filterframe, "style", "text", ...
		 						    "string", "Noise type", ...
		 						    "fontsize", 12, ...
		 						    "fontweight", "bold", ...
		 						    "fontangle", "italic", ...
		 						    "position", [210 235 150 30], ...
		 						    "HorizontalAlignment", "center");
	 	//Item list
  		new_frame_list = uicontrol(filterframe , "style" , "listbox");
  		new_frame_list.String = ["Bruit_de_perlin" "Poivre_&_sel"];
  		new_frame_list.position = [0 210 200 80];
  		new_frame_list.Value = 1;
  		new_frame_list.BackgroundColor=[1 1 1];
  		//Noise factor
  		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Noise factor", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "0.02";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 0.5;
	 	new_slider_item1.SliderStep = [0.01 0.01];
	 	new_slider_item1.Value = 0.02;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(double(new_slider_item1.value))"
  	end
	 if filterlist.Value == 18 //Halftoning 1
	 	clf(filterframe,"reset");
	 end
	 if filterlist.Value == 19 //Halftoning 2
	 	clf(filterframe,"reset");
	 end
	 	if filterlist.Value == 20 //Swirl
		clf(filterframe,"reset");
		   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
		 						    "string", "Pi divider", ...
		 						    "fontsize", 12, ...
		 						    "fontweight", "bold", ...
		 						    "fontangle", "italic", ...
		 						    "position", [170 0 150 30], ...
		 						    "HorizontalAlignment", "center");
		 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
		 	new_slider_item1_text.Position = [110 0 50 30];
		 	new_slider_item1_text.String = "80";
		 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
	   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
		 	new_slider_item1.Position = [0 0 100 30];
		 	new_slider_item1.min = 0;
		 	new_slider_item1.max = 10000;
		 	new_slider_item1.SliderStep = [1 1];
		 	new_slider_item1.value = 80;
		 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint16(new_slider_item1.value))"
	 end
	 if filterlist.Value == 21 //Fisheye
	 	clf(filterframe,"reset");
	 end
	 if filterlist.Value == 22 //time_warp
	 	clf(filterframe,"reset");
	 end
		if filterlist.Value == 23 // Wave
			//Wave factor
   		clf(filterframe,"reset");
   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Wave factor", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "10";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 0;
	 	new_slider_item1.max = 100;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.Value = 10;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
	 	//v_distord?
	 	 new_slider_item2_desc = uicontrol(filterframe, "style", "text", ...
	 						    "string", "Vertical distorsion ?", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 40 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item2_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item2_text.Position = [110 40 50 30];
	 	new_slider_item2_text.String = "1";
	 	new_slider_item2_text.Callback = "new_slider_item2.Value = new_slider_item2_text.String";
   		new_slider_item2 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item2.Position = [0 40 100 30];
	 	new_slider_item2.min = 0;
	 	new_slider_item2.max = 1;
	 	new_slider_item2.SliderStep = [1 1];
	 	new_slider_item2.Value = 1;
	 	new_slider_item2.Callback = "new_slider_item2_text.String = string(uint8(new_slider_item2.value))"
	 	//h_distord?
   		new_slider_item3_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Horizontal distorsion ?", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 80 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item3_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item3_text.Position = [110 80 50 30];
	 	new_slider_item3_text.String = "1";
	 	new_slider_item3_text.Callback = "new_slider_item3.Value = new_slider_item3_text.String";
   		new_slider_item3 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item3.Position = [0 80 100 30];
	 	new_slider_item3.min = 0;
	 	new_slider_item3.max = 1;
	 	new_slider_item3.SliderStep = [1 1];
	 	new_slider_item3.Value = 1;
	 	new_slider_item3.Callback = "new_slider_item3_text.String = string(uint8(new_slider_item3.value))"
	 	end
	 	if filterlist.Value == 24 // Convolute
			//Filter X
   		clf(filterframe,"reset");
	 	//desc
  		new_frame_list_desc = uicontrol(filterframe, "style", "text", ...
		 						    "string", "Border mode", ...
		 						    "fontsize", 12, ...
		 						    "fontweight", "bold", ...
		 						    "fontangle", "italic", ...
		 						    "position", [210 235 150 30], ...
		 						    "HorizontalAlignment", "center");
	 	//Item list
  		new_frame_list = uicontrol(filterframe , "style" , "listbox");
  		new_frame_list.String = ["Border_to_zero" "Partial_convolution" "Mirror_borders"];
  		new_frame_list.position = [0 210 200 80];
  		new_frame_list.Value = 3;
  		new_frame_list.BackgroundColor=[1 1 1];
  		new_frame_list.Callback = "up_common(new_frame_list)";
	 	//desc 2
  		new_frame_list2_desc = uicontrol(filterframe, "style", "text", ...
		 						    "string", "Filter used", ...
		 						    "fontsize", 12, ...
		 						    "fontweight", "bold", ...
		 						    "fontangle", "italic", ...
		 						    "position", [210 155 150 30], ...
		 						    "HorizontalAlignment", "center");
	 	//Item list 2
  		new_frame_list2 = uicontrol(filterframe , "style" , "listbox");
  		new_frame_list2.String = ["Moyenneur" "Sharpener" "Gaussien" "Sobel" "Laplacien"];
  		new_frame_list2.position = [0 130 200 80];
  		new_frame_list2.Value = 1;
  		new_frame_list2.BackgroundColor=[1 1 1];
  		new_frame_list2.Callback = "up_common(new_frame_list2)";
		//Filter
		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Filter size", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "3";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 3;
	 	new_slider_item1.max = 15;
	 	new_slider_item1.SliderStep = [1 1];
	 	new_slider_item1.Value = 3;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
	 	//Filter Y
	 	new_slider_item2_desc = uicontrol(filterframe, "style", "text", ...
	 						    "string", "Sigma(Only f/ Gauss)", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 40 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item2_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item2_text.Position = [110 40 50 30];
	 	new_slider_item2_text.String = "1.4";
	 	new_slider_item2_text.Callback = "new_slider_item2.Value = new_slider_item2_text.String";
   		new_slider_item2 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item2.Position = [0 40 100 30];
	 	new_slider_item2.min = 0;
	 	new_slider_item2.max = 3;
	 	new_slider_item2.SliderStep = [0.1 0.1];
	 	new_slider_item2.Value = 1.4;
	 	new_slider_item2.Callback = "new_slider_item2_text.String = string(double(new_slider_item2.value))"
	 	//Sobel direction
   		new_slider_item3_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "D G H B(Sobel dir)", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 80 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item3_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item3_text.Position = [110 80 50 30];
	 	new_slider_item3_text.String = "1";
	 	new_slider_item3_text.Callback = "new_slider_item3.Value = new_slider_item3_text.String";
   		new_slider_item3 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item3.Position = [0 80 100 30];
	 	new_slider_item3.min = 1;
	 	new_slider_item3.max = 4;
	 	new_slider_item3.SliderStep = [1 1];
	 	new_slider_item3.Value = 1;
	 	new_slider_item3.Callback = "new_slider_item3_text.String = string(uint8(new_slider_item3.value))"
	 	end
		if filterlist.Value == 25 // Median
			//Filter X
   		clf(filterframe,"reset");
   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Filter X (Impair)", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "3";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 3;
	 	new_slider_item1.max = 15;
	 	new_slider_item1.SliderStep = [2 2];
	 	new_slider_item1.Value = 3;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
	 	//Filter Y
	 	 new_slider_item2_desc = uicontrol(filterframe, "style", "text", ...
	 						    "string", "Filter Y (Impair)", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 40 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item2_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item2_text.Position = [110 40 50 30];
	 	new_slider_item2_text.String = "3";
	 	new_slider_item2_text.Callback = "new_slider_item2.Value = new_slider_item2_text.String";
   		new_slider_item2 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item2.Position = [0 40 100 30];
	 	new_slider_item2.min = 3;
	 	new_slider_item2.max = 15;
	 	new_slider_item2.SliderStep = [2 2];
	 	new_slider_item2.Value = 3;
	 	new_slider_item2.Callback = "new_slider_item2_text.String = string(uint8(new_slider_item2.value))"
	 	//desc
  		new_frame_list_desc = uicontrol(filterframe, "style", "text", ...
		 						    "string", "Border mode", ...
		 						    "fontsize", 12, ...
		 						    "fontweight", "bold", ...
		 						    "fontangle", "italic", ...
		 						    "position", [210 235 150 30], ...
		 						    "HorizontalAlignment", "center");
	 	//Item list
  		new_frame_list = uicontrol(filterframe , "style" , "listbox");
  		new_frame_list.String = ["Border_to_zero" "Partial_convolution" "Mirror_borders"];
  		new_frame_list.position = [0 210 200 80];
  		new_frame_list.Value = 3;
  		new_frame_list.BackgroundColor=[1 1 1];
	 	end
	 	if filterlist.Value == 26 // despeckle
			//Filter X
   		clf(filterframe,"reset");
   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Filter X (Impair)", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "3";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 3;
	 	new_slider_item1.max = 15;
	 	new_slider_item1.SliderStep = [2 2];
	 	new_slider_item1.Value = 3;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
	 	//Filter Y
	 	 new_slider_item2_desc = uicontrol(filterframe, "style", "text", ...
	 						    "string", "Filter Y (Impair)", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 40 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item2_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item2_text.Position = [110 40 50 30];
	 	new_slider_item2_text.String = "3";
	 	new_slider_item2_text.Callback = "new_slider_item2.Value = new_slider_item2_text.String";
   		new_slider_item2 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item2.Position = [0 40 100 30];
	 	new_slider_item2.min = 3;
	 	new_slider_item2.max = 15;
	 	new_slider_item2.SliderStep = [2 2];
	 	new_slider_item2.Value = 3;
	 	new_slider_item2.Callback = "new_slider_item2_text.String = string(uint8(new_slider_item2.value))"
	 	//desc
  		new_frame_list_desc = uicontrol(filterframe, "style", "text", ...
		 						    "string", "Border mode", ...
		 						    "fontsize", 12, ...
		 						    "fontweight", "bold", ...
		 						    "fontangle", "italic", ...
		 						    "position", [210 235 150 30], ...
		 						    "HorizontalAlignment", "center");
	 	//Item list
  		new_frame_list = uicontrol(filterframe , "style" , "listbox");
  		new_frame_list.String = ["Border_to_zero" "Partial_convolution"];
  		new_frame_list.position = [0 210 200 80];
  		new_frame_list.Value = 2;
  		new_frame_list.BackgroundColor=[1 1 1];
	 	end
		if filterlist.Value == 27 // Outlining
			//Filter X
   		clf(filterframe,"reset");
   		new_slider_item1_desc =uicontrol(filterframe, "style", "text", ...
	 						    "string", "Filter size (Impair)", ...
	 						    "fontsize", 12, ...
	 						    "fontweight", "bold", ...
	 						    "fontangle", "italic", ...
	 						    "position", [170 0 150 30], ...
	 						    "HorizontalAlignment", "center");
	 	new_slider_item1_text = uicontrol(filterframe, "style", "edit");
	 	new_slider_item1_text.Position = [110 0 50 30];
	 	new_slider_item1_text.String = "3";
	 	new_slider_item1_text.Callback = "new_slider_item1.Value = new_slider_item1_text.String";
   		new_slider_item1 = uicontrol(filterframe , "style" , "slider");
	 	new_slider_item1.Position = [0 0 100 30];
	 	new_slider_item1.min = 3;
	 	new_slider_item1.max = 15;
	 	new_slider_item1.SliderStep = [2 2];
	 	new_slider_item1.Value = 3;
	 	new_slider_item1.Callback = "new_slider_item1_text.String = string(uint8(new_slider_item1.value))"
	 	//desc
  		new_frame_list_desc = uicontrol(filterframe, "style", "text", ...
		 						    "string", "Border mode", ...
		 						    "fontsize", 12, ...
		 						    "fontweight", "bold", ...
		 						    "fontangle", "italic", ...
		 						    "position", [210 235 150 30], ...
		 						    "HorizontalAlignment", "center");
	 	//Item list
  		new_frame_list = uicontrol(filterframe , "style" , "listbox");
  		new_frame_list.String = ["Border_to_zero" "Partial_convolution" "Mirror_borders"];
  		new_frame_list.position = [0 210 200 80];
  		new_frame_list.Value = 3;
  		new_frame_list.BackgroundColor=[1 1 1];
	 	end

endfunction
//APPLY CALLBACK
function [new_current_s_image, new_current_ns_image] = my_applycall(filterlist, current_ns_image, slider_item1 ,slider_item1_text,slider_item1_desc , slider_item2 ,slider_item2_text,slider_item2_desc , slider_item3 ,slider_item3_text,slider_item3_desc , slider_item4 ,slider_item4_text,slider_item4_desc,frame_list,frame_list2)
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
		new_current_s_image = bit_reduce(current_ns_image , slider_item1.value);
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
		new_current_s_image = flip(current_ns_image , frame_list.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==13 then
		new_current_s_image = tiling(current_ns_image , [slider_item1.value slider_item2.value], [slider_item3.value slider_item4.value]);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==14 then
		new_current_s_image = glassy(current_ns_image , [slider_item1.value slider_item2.value]);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==15 then
		new_current_s_image = mosaic(current_ns_image , [slider_item1.value slider_item2.value]);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==16 then
		new_current_s_image = oil_painting(current_ns_image , [slider_item1.value slider_item2.value]);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.value ==17 then
		new_current_s_image = noisify(current_ns_image,frame_list.value,slider_item1.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==18 then
		new_current_s_image = halftoning(current_ns_image);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==19 then
		new_current_s_image = halftoning2(current_ns_image);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==20 then
		new_current_s_image = swirl(current_ns_image , (%pi/slider_item1.value));
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==21 then
		new_current_s_image = fisheye(current_ns_image);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==22 then
		new_current_s_image = time_warp(current_ns_image);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==23 then
		new_current_s_image = wave(current_ns_image, slider_item1.value, slider_item2.value, slider_item3.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==24 then
		
		if frame_list2.value == 1 then
			new_current_s_image = convolute(current_ns_image, moyenneur(slider_item1.Value) , frame_list.value);
			new_current_ns_image = new_current_s_image;
			imshow(new_current_s_image);
		end

		if frame_list2.value == 2 then
			new_current_s_image = convolute(current_ns_image, sharpener(slider_item1.Value) , frame_list.value);
			new_current_ns_image = new_current_s_image;
			imshow(new_current_s_image);
		end

		if frame_list2.value == 3 then
			new_current_s_image = convolute(current_ns_image, gaussien(slider_item1.Value,slider_item2.value) , frame_list.value);
			new_current_ns_image = new_current_s_image;
			imshow(new_current_s_image);
		end
		
		if frame_list2.value == 4 then
			[DROITE GAUCHE HAUT BAS] = sobel(slider_item1.value);

			if slider_item3.value == 1 then	
				new_current_s_image = convolute(current_ns_image, DROITE, frame_list.value);
				new_current_ns_image = new_current_s_image;
				imshow(new_current_s_image);
			end
			
			if slider_item3.value == 2 then	
				new_current_s_image = convolute(current_ns_image, GAUCHE, frame_list.value);
				new_current_ns_image = new_current_s_image;
				imshow(new_current_s_image);
			end
			
			if slider_item3.value == 3 then	
				new_current_s_image = convolute(current_ns_image, HAUT, frame_list.value);
				new_current_ns_image = new_current_s_image;
				imshow(new_current_s_image);
			end

			if slider_item3.value == 4 then	
				new_current_s_image = convolute(current_ns_image, BAS, frame_list.value);
				new_current_ns_image = new_current_s_image;
				imshow(new_current_s_image);
			end
		end

		if frame_list2.value == 5 then
			new_current_s_image = convolute(current_ns_image, laplacien(slider_item1.value) , frame_list.value);
			new_current_ns_image = new_current_s_image;
			imshow(new_current_s_image);
		end

	end
	if filterlist.Value ==25 then
		new_current_s_image = median_filter(current_ns_image, [slider_item1.value slider_item2.value], frame_list.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==26 then
		new_current_s_image = despeckle(current_ns_image, [slider_item1.value slider_item2.value], frame_list.value);
		new_current_ns_image = new_current_s_image;
		imshow(new_current_s_image);
		end
	if filterlist.Value ==27 then
		new_current_s_image = outlining(current_ns_image, slider_item1.value, frame_list.value);
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

//CLOSE CALLBACK
function [] = my_closecall(fig_handle)
	close(fig_handle);
	clear
endfunction

//MAIN UI

//Figure init
hmain = scf();
fig_item = figure(0 , "position" , [0 0 400 600]);

//Picture section
picture_sect_item = uimenu(fig_item,'label', 'Picture');

//File subsection
file_sub_item = uimenu(picture_sect_item,'label','File');

load_file_item = uimenu(file_sub_item ,'label', 'Load picture', 'callback',"[base_image,current_s_image,current_ns_image] = my_load(supported_formats)");
save_file_item = uimenu(file_sub_item ,'label', 'Save picture', 'callback',"my_save(supported_formats,current_s_image)");

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
filterlist.String = ["rvb2nb" "negative" "linear_extension" "histo_equalizer" "brightness" "exposure" "glitch" "seuillage" "bit_reduce" "color_blend" "zoom" "flip" "tiling" "glassy" "mosaic" "oil" "noisify" "halftoning" "superior_halftoning" "swirl" "fisheye" "time_warp" "wave" "convolute" "median" "despeckle" "oulining"];
filterlist.Value = 1;
filterlist.BackgroundColor=[1 1 1];
filterlist.Callback = "[new_slider_item1,new_slider_item1_text,new_slider_item1_desc,new_slider_item2,new_slider_item2_text,new_slider_item2_desc,new_slider_item3,new_slider_item3_text,new_slider_item3_desc,new_slider_item4,new_slider_item4_text,new_slider_item4_desc, new_frame_list , new_frame_list_desc, new_frame_list2,new_frame_list2_desc] = updatelistbox(filterlist, filterframe)";

//Apply button
apply_button = uicontrol(fig_item, "style" , "pushbutton");
apply_button.String = "Apply";
apply_button.Position = [150 80 100 30];
apply_button.Callback = "[current_s_image,current_ns_image] = my_applycall(filterlist,current_s_image,new_slider_item1, new_slider_item1_text, new_slider_item1_desc, new_slider_item2, new_slider_item2_text, new_slider_item2_desc, new_slider_item3, new_slider_item3_text, new_slider_item3_desc,new_slider_item4, new_slider_item4_text, new_slider_item4_desc,new_frame_list,new_frame_list2)";

//Refresh button
refresh_button = uicontrol(fig_item, "style" , "pushbutton");
refresh_button.String = "Refresh";
refresh_button.Position = [50 40 100 30];
refresh_button.Callback = "[current_s_image,current_ns_image] = my_refreshcall(base_image);";


//Show button
undo_button = uicontrol(fig_item, "style" , "pushbutton");
undo_button.String = "Show";
undo_button.Position = [250 40 100 30];
undo_button.Callback = "my_showcall(current_s_image)";

//Quit button
apply_button = uicontrol(fig_item, "style" , "pushbutton");
apply_button.String = "Quit";
apply_button.Position = [150 5 100 30];
apply_button.Callback = "my_closecall(hmain)";

//  Convolute filters:
//	1: moyenneur (T(3)) impair 3 15
//	2: sharpener (T(3)) 
//	3: gaussien  (T(3), sigma(1.4) 0 db 3)
//	4: sobel (T(3)), impair 3 15
//	5: laplacien (T(8) 4 ou 8)	
//
//	convolute border modes:
//	1: border to 0
//	2: partiel convolution
//	3: mirror border

//FUNCTIONS
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

// 	14: glassy (im, brush_size(3 3)0 +inf)
//	15: mosaic (im , piece_size (6 6)0 +inf)
//	16: oil painting (im , brush_size(7 7)0 +inf)
//	17: noisify (im , noise_type(perlin|saltpepper), noise_factor(0.02)0 0.5)
//	18: halftoning (im)
//	19:	halftoning 2 superior (im)
//	20: swirl (im,r_degree(%pi/80))
//	21:	fisheye (im)
//	22: time_warp (im)
//	23: wave (im,wave factor(10)0 100,v_distord(true)%t %f, h_distord(true)%t %f)
//	24: convolute (im,flt,bordermode(3))
//	25: median (im, filter_size(3 3)impair ~ same 3 15, border_mode(3))
//	26:	despeckle (im , filter_size(3 3), border_mode(2))
//	27: oulining (im, filter_size(3 3), border_mode(3))
/// @description Add menu items

array_push(menu_items, 
	{
		label : "Resume",
		
		execute : function()
		{
			gamestate.toggle_game_pause();
			menu_pause.visible = false;
		}
		
	});
	
array_push(menu_items, 
	{
		label : "Exit Game",
		
		execute : function()
		{
			gamestate.exit_game();	
		}
		
	});
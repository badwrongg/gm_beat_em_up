/// @description Gamestate functions

#region Functions
	
	function toggle_game_pause()
	{
		if (game_paused)
		{
			with (__entity)
				image_speed = anim_speed;
			
			game_paused = false;
			anim_speed  = 1;
			get_game_camera(0).active = true;
			audio_group_set_gain(audio_bgm, 1, 500);
			menu_pause.visible = false;
			
			game_state = gs_gameplay;
		}
		else
		{
			with (__entity)
				image_speed = 0;
			
			game_paused = true;
			anim_speed  = 0;
			get_game_camera(0).active = false;
			audio_group_set_gain(audio_bgm, 0.2, 500);
			menu_pause.visible = true;	
			
			game_state = gs_pause_menu;
		}
	}
	
	function exit_game()
	{
		// TODO save stuff etc.
		game_end();
	}
	
#endregion

#region States

	function gs_none()
	{
		
	}

	function gs_room_load_world()
	{
		if (global.room_loaded) // TODO And other loading checks
		{
			game_paused = false;
			game_state  = gs_gameplay;
		}
	}

	function gs_gameplay()
	{
		if (keyboard_check_pressed(vk_escape))
			toggle_game_pause();		
		else
		{
			for (var _i = 0; _i < entity_count; _i++)
				entity_list[| _i].event_tick();
		}
	}
	
	function gs_pause_menu()
	{
		if (keyboard_check_pressed(vk_escape))
			toggle_game_pause();
	}
	
#endregion
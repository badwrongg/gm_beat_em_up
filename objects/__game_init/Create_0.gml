load_stack = ds_stack_create();

// Push loader structs onto the stack
// ** Last pushed is first executed **

ds_stack_push(load_stack, new loader_game_data());
ds_stack_push(load_stack, new loader_assets());
ds_stack_push(load_stack, new loader_system());

enum e_game_init
{
	core,
	gui,
	last
}

load_state = e_game_init.core;
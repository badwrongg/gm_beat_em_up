// Effect functions that use the depth particle systems

function effect_create_hit_white(_x, _y, _depth)
{
	static _part = get_particle_type(e_part_type.hit_white);
	audio_play_sound(sfx_hit, 5, false);
	part_particles_create(get_particle_system_at_depth(_depth), _x, _y, _part, 4);	
}

function effect_create_impact_physical(_x, _y, _depth)
{
	static _part = get_particle_type(e_part_type.impact_physical);
	
	if (!audio_is_playing(sfx_hit))
		audio_play_sound(sfx_hit, 5, false);
		
	part_particles_create(get_particle_system_at_depth(_depth), _x, _y, _part, 1);	
}
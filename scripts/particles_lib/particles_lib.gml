// Multiple particle systems are used to draw particles at different depths
// Calling get_particle_system_at_depth() will give the next system in the container
// and assign it a depth (bbox_bottom) which can then be sorted into the draw call
// from the gamestate.

function particle_system() constructor
{
	// Automatic draw is off, the gamestate calls it
	id = part_system_create();
	part_system_automatic_draw(id, false);
	part_system_automatic_update(id, false);
	
	bbox_bottom = 0;
		
	static draw_script = function() 
	{ 
		part_system_update(id);
		part_system_drawit(id); 
	}
	static destroy = function() { part_system_destroy(id); }
	static clear   = function() { part_system_clear(id); }
}

function create_particles_types()
{
	// All the particle types are stored statically and shared
	
	enum e_part_type
	{
		hit_red,
		hit_white,
		impact_physical,
		last
	}
	
	var _types = array_create_ext(e_part_type.last, part_type_create),
		_part  = noone;
	
	_part = _types[e_part_type.hit_red];
		part_type_shape(_part, pt_shape_flare);
		part_type_size(_part, 0.1, 0.4, -0.05, 0);
		part_type_color2(_part, c_red, c_orange);
		part_type_alpha2(_part, 0.9, 0.4);
		part_type_speed(_part, 2, 5, 0.1, 0);
		part_type_direction(_part, 0, 359, 0, 0);
		part_type_orientation(_part, 0, 360, 0, 0, false);
		part_type_life(_part, 35, 45);
	
	_part = _types[e_part_type.hit_white];
		part_type_shape(_part, pt_shape_explosion);
		part_type_size(_part, 0.5, 0.8, -0.005, 0);
		part_type_color2(_part, c_white, c_gray);
		part_type_alpha2(_part, 0.9, 0.1);
		part_type_speed(_part, 0.2, 0.4, 0.1, 0);
		part_type_direction(_part, 0, 359, 0, 0);
		part_type_orientation(_part, 0, 360, 0, 0, false);
		part_type_life(_part, 35, 45);
		
	_part = _types[e_part_type.impact_physical];
		part_type_sprite(_part, spr_impact_physical, true, true, false);
		part_type_size(_part, 0.9, 1.1, 0, 0);
		part_type_alpha2(_part, 0.9, 0.1);
		part_type_orientation(_part, 0, 360, 0, 0, false);
		part_type_life(_part, 35, 45);

	return _types;
}

function get_particle_type(_type)
{
	// The static array of particle types
	static _part_types = create_particles_types();
	return _part_types[_type];
}

function get_particle_systems()
{
	// The static array of particle systems
	static _systems = array_create_ext(C_PARTICLE_SYSTEM_COUNT, function(){ return new particle_system(); });
	return _systems;		
}

function get_particle_system_at_depth(_depth)
{
	// Gets the next particle system and assigns it the requested depth
	static _systems = get_particle_systems();
	static _index   = 0;
	
	var _system = _systems[_index];
	_system.bbox_bottom = _depth + 1; // Place it right in front of what made it
	_index = (_index + 1) mod C_PARTICLE_SYSTEM_COUNT;
	
	return _system.id;
}
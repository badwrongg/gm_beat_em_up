// Combat related functions

function hurtbox_create(_x, _y, _owner, _sprite)
{
	return instance_create_depth(_x, _y, 0, __hurtbox,
			{
				owner      : _owner,
				mask_index : _sprite,
			});
}

function hurtbox_receive_attack(_attack, _source)
{	
	return owner.receive_attack(_attack, _source);
}

function hurtbox_set_position(_x, _y, _image_xscale)
{
	x = _x;
	y = _y;
	image_xscale = _image_xscale;
}

function prop_receive_attack(_attack, _source)
{
	// Props receive attacks differently than characters
	
	if (_source.team != e_team.player)
		return 0;
		
	image_index++;
	
	// TODO add a hit effect
	
	if (image_index == image_number)
		destroy_this = true;
		
	return 1;
}

function create_attack_params(
	_damage, 
	_knockback = 0, 
	_knockup = 0, 
	_hit_effect = effect_create_impact_physical,
	_attack_type = e_attack_type.high)
{
	// Convenient way to define attack params
	return [_damage, _knockback, _knockup, _hit_effect, _attack_type];	
}
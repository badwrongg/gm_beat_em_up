/// @description Destroy Entities

for (var _i = entity_count - 1, _id = noone; _i > -1; _i--)
{
	_id = entity_list[| _i];
	
	if (_id.destroy_this)
	{
		ds_list_delete(entity_list, _i);
		instance_destroy(_id);
		entity_count--;
	}
}
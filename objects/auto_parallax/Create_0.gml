// Automatically scrolls multiple parallax layers with the camera's position
// Populate the arrays with layer names, x and y speeds, and the y offset

// Each entry should match the same index of the other arrays
// The speeds scale off the camera position, so smaller values 
// make the layers appear further away.

// Set the camera object asset name as well to whatever camera object you use

camera = get_game_camera(camera_index);
layer_ids = [];

for (var _l = 0, _len = array_length(layer_names); _l < _len; _l++)
{
	var _id = layer_get_id(layer_names[_l]);
	if (_id != -1)
		array_push(layer_ids, _id);	
}

layer_count = array_length(layer_ids);
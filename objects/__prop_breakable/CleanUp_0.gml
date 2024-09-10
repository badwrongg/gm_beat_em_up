instance_destroy(hurtbox);

with (prop_collider)
{
	// Remove collider area from the navgrid
	
	var _hcells = (bbox_right div C_NAVGRID_CELL_WIDTH) + 1,
		_vcells = (bbox_bottom div C_NAVGRID_CELL_HEIGHT) + 1,
		_hstart = bbox_left div C_NAVGRID_CELL_WIDTH,
		_vstart = bbox_top div C_NAVGRID_CELL_HEIGHT,
		_left   = _hstart * C_NAVGRID_CELL_WIDTH,
		_top    = _vstart * C_NAVGRID_CELL_HEIGHT,
		_grid   = global.navgrid;

	for (var _cx = _hstart; _cx < _hcells; _cx++)
	{
		for (var _cy = _vstart; _cy < _vcells; _cy++)
		{
			// Clear cell if no collision found from another collider in this cell
			if (!collision_rectangle(_left, _top, _left + C_NAVGRID_CELL_WIDTH, _top + C_NAVGRID_CELL_HEIGHT, __collider_all, false, true))
				mp_grid_clear_cell(_grid, _cx, _cy);
						
			_top += C_NAVGRID_CELL_HEIGHT;
		}
		_top = _vstart * C_NAVGRID_CELL_HEIGHT;
		_left += C_NAVGRID_CELL_WIDTH;
	}

	instance_destroy(id);
}
